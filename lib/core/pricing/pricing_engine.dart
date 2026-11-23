import '../domain/pricing_models.dart';

class PricingEngine {
  const PricingEngine();

  PriceBreakdown calculate(PricingInput input) {
    input.settings.validate();
    _validateNonNegative(input);

    final selectedPlates = input.project.plates.where(
      (plate) => plate.selected,
    );
    final materialLines = <MaterialCostLine>[];
    var totalDurationSeconds = 0;
    var totalPlateRuns = 0;
    var finishedUnits = 0;

    for (final plate in selectedPlates) {
      totalDurationSeconds += plate.durationSeconds * plate.plateRuns;
      totalPlateRuns += plate.plateRuns;
      finishedUnits += plate.finishedUnits;
      for (final material in plate.materials) {
        final profileId = material.materialProfileId;
        if (profileId == null) {
          throw FormatException(
            'Tool ${material.toolIndex + 1} on ${plate.name} has no confirmed material profile.',
          );
        }
        final profile = input.materialProfiles[profileId];
        if (profile == null) {
          throw FormatException('Material profile $profileId does not exist.');
        }
        if (profile.nominalMassMg <= 0) {
          throw FormatException('${profile.name} has an invalid spool weight.');
        }
        final massMg = material.totalConsumedMassMg * plate.plateRuns;
        final costMicros = _divideRounded(
          BigInt.from(massMg) * BigInt.from(profile.spoolPriceMicros),
          BigInt.from(profile.nominalMassMg),
        );
        materialLines.add(
          MaterialCostLine(
            plateId: plate.id,
            profileId: profileId,
            toolIndex: material.toolIndex,
            massMg: massMg,
            costMicros: costMicros,
          ),
        );
      }
    }

    final materialMicros = materialLines.fold<int>(
      0,
      (sum, line) => sum + line.costMicros,
    );
    final electricityMicros = _divideRounded(
      BigInt.from(totalDurationSeconds) *
          BigInt.from(input.printer.watts) *
          BigInt.from(input.settings.electricityRateMicrosPerKwh),
      BigInt.from(3600 * 1000),
    );
    final machineMicros = _divideRounded(
      BigInt.from(totalDurationSeconds) *
          BigInt.from(input.printer.machineRateMicrosPerHour),
      BigInt.from(3600),
    );
    final repeatableProductionMicros =
        materialMicros + electricityMicros + machineMicros;
    final failureReserveMicros = _basisPoints(
      repeatableProductionMicros,
      input.settings.failureAllowanceBasisPoints,
    );

    var laborMinutes =
        input.setupLaborMinutes +
        (input.perPlateLaborMinutes * totalPlateRuns) +
        (input.perUnitFinishingMinutes * finishedUnits);
    var extrasMicros = 0;
    for (final extra in input.extras) {
      final multiplier = switch (extra.scope) {
        CostScope.order => 1,
        CostScope.plateRun => totalPlateRuns,
        CostScope.finishedUnit => finishedUnits,
      };
      extrasMicros += extra.unitCostMicros * multiplier;
      laborMinutes += extra.laborMinutes * multiplier;
    }
    final laborMicros = _divideRounded(
      BigInt.from(laborMinutes) *
          BigInt.from(input.settings.laborRateMicrosPerHour),
      BigInt.from(60),
    );
    final packagingMicros =
        input.orderPackagingMicros +
        input.perUnitPackagingMicros * finishedUnits;
    final totalCostMicros =
        repeatableProductionMicros +
        failureReserveMicros +
        laborMicros +
        extrasMicros +
        packagingMicros +
        input.shippingMicros;

    final denominator =
        10000 -
        input.settings.platformFeeBasisPoints -
        input.settings.targetMarginBasisPoints;
    final calculatedPreTaxPriceMicros = _divideRounded(
      BigInt.from(totalCostMicros + input.settings.platformFixedFeeMicros) *
          BigInt.from(10000),
      BigInt.from(denominator),
    );
    final preTaxPriceMicros =
        calculatedPreTaxPriceMicros < input.settings.minimumOrderMicros
        ? input.settings.minimumOrderMicros
        : calculatedPreTaxPriceMicros;
    final minimumFloorAdjustmentMicros =
        preTaxPriceMicros - calculatedPreTaxPriceMicros;
    final percentageFeeMicros = _basisPoints(
      preTaxPriceMicros,
      input.settings.platformFeeBasisPoints,
    );
    final platformFeeMicros =
        percentageFeeMicros + input.settings.platformFixedFeeMicros;
    final taxMicros = _basisPoints(
      preTaxPriceMicros,
      input.settings.taxBasisPoints,
    );
    final finalPriceMicros = preTaxPriceMicros + taxMicros;
    final netProfitMicros =
        preTaxPriceMicros - platformFeeMicros - totalCostMicros;
    final effectiveMarginBasisPoints = preTaxPriceMicros == 0
        ? 0
        : _divideRounded(
            BigInt.from(netProfitMicros) * BigInt.from(10000),
            BigInt.from(preTaxPriceMicros),
          );
    final profitPerPrinterHourMicros = totalDurationSeconds == 0
        ? 0
        : _divideRounded(
            BigInt.from(netProfitMicros) * BigInt.from(3600),
            BigInt.from(totalDurationSeconds),
          );

    return PriceBreakdown(
      materialLines: List.unmodifiable(materialLines),
      materialMicros: materialMicros,
      electricityMicros: electricityMicros,
      machineMicros: machineMicros,
      failureReserveMicros: failureReserveMicros,
      laborMicros: laborMicros,
      extrasMicros: extrasMicros,
      packagingMicros: packagingMicros,
      shippingMicros: input.shippingMicros,
      totalCostMicros: totalCostMicros,
      calculatedPreTaxPriceMicros: calculatedPreTaxPriceMicros,
      minimumFloorAdjustmentMicros: minimumFloorAdjustmentMicros,
      preTaxPriceMicros: preTaxPriceMicros,
      platformFeeMicros: platformFeeMicros,
      taxMicros: taxMicros,
      finalPriceMicros: finalPriceMicros,
      netProfitMicros: netProfitMicros,
      effectiveMarginBasisPoints: effectiveMarginBasisPoints,
      profitPerPrinterHourMicros: profitPerPrinterHourMicros,
      totalDurationSeconds: totalDurationSeconds,
      totalPlateRuns: totalPlateRuns,
      finishedUnits: finishedUnits,
    );
  }

  void _validateNonNegative(PricingInput input) {
    final values = <int>[
      input.setupLaborMinutes,
      input.perPlateLaborMinutes,
      input.perUnitFinishingMinutes,
      input.perUnitPackagingMicros,
      input.orderPackagingMicros,
      input.shippingMicros,
      input.printer.watts,
      input.printer.machineRateMicrosPerHour,
    ];
    if (values.any((value) => value < 0)) {
      throw const FormatException('Pricing inputs cannot be negative.');
    }
  }

  int _basisPoints(int value, int basisPoints) => _divideRounded(
    BigInt.from(value) * BigInt.from(basisPoints),
    BigInt.from(10000),
  );

  int _divideRounded(BigInt numerator, BigInt denominator) {
    if (denominator <= BigInt.zero) {
      throw const FormatException('A pricing denominator must be positive.');
    }
    final isNegative = numerator.isNegative;
    final absolute = numerator.abs();
    final rounded = (absolute + (denominator ~/ BigInt.two)) ~/ denominator;
    return (isNegative ? -rounded : rounded).toInt();
  }
}
