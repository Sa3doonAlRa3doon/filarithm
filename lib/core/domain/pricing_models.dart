import 'print_project.dart';

class MaterialProfile {
  const MaterialProfile({
    required this.id,
    required this.name,
    required this.materialType,
    required this.colorHex,
    required this.spoolPriceMicros,
    required this.nominalMassMg,
    this.brand,
    this.densityMicrogramsPerCubicMillimeter = 1240,
  }) : assert(spoolPriceMicros >= 0),
       assert(nominalMassMg > 0),
       assert(densityMicrogramsPerCubicMillimeter > 0);

  final String id;
  final String name;
  final String materialType;
  final String colorHex;
  final String? brand;
  final int spoolPriceMicros;
  final int nominalMassMg;
  final int densityMicrogramsPerCubicMillimeter;
}

class PrinterProfile {
  const PrinterProfile({
    required this.id,
    required this.name,
    required this.watts,
    required this.machineRateMicrosPerHour,
  }) : assert(watts >= 0),
       assert(machineRateMicrosPerHour >= 0);

  final String id;
  final String name;
  final int watts;
  final int machineRateMicrosPerHour;
}

enum CostScope { order, plateRun, finishedUnit }

class ExtraCost {
  const ExtraCost({
    required this.name,
    required this.unitCostMicros,
    this.scope = CostScope.order,
    this.laborMinutes = 0,
  }) : assert(unitCostMicros >= 0),
       assert(laborMinutes >= 0);

  final String name;
  final int unitCostMicros;
  final CostScope scope;
  final int laborMinutes;
}

class PricingSettings {
  const PricingSettings({
    required this.electricityRateMicrosPerKwh,
    required this.laborRateMicrosPerHour,
    required this.failureAllowanceBasisPoints,
    required this.targetMarginBasisPoints,
    required this.platformFeeBasisPoints,
    required this.platformFixedFeeMicros,
    required this.taxBasisPoints,
    this.minimumOrderMicros = 0,
    this.currencyCode = 'AED',
  });

  final int electricityRateMicrosPerKwh;
  final int laborRateMicrosPerHour;
  final int failureAllowanceBasisPoints;
  final int targetMarginBasisPoints;
  final int platformFeeBasisPoints;
  final int platformFixedFeeMicros;
  final int taxBasisPoints;
  final int minimumOrderMicros;
  final String currencyCode;

  void validate() {
    final values = <int>[
      electricityRateMicrosPerKwh,
      laborRateMicrosPerHour,
      failureAllowanceBasisPoints,
      targetMarginBasisPoints,
      platformFeeBasisPoints,
      platformFixedFeeMicros,
      taxBasisPoints,
      minimumOrderMicros,
    ];
    if (values.any((value) => value < 0)) {
      throw const FormatException('Pricing inputs cannot be negative.');
    }
    if (targetMarginBasisPoints + platformFeeBasisPoints >= 10000) {
      throw const FormatException(
        'Target margin plus percentage platform fee must be below 100%.',
      );
    }
  }
}

class PricingInput {
  const PricingInput({
    required this.project,
    required this.materialProfiles,
    required this.printer,
    required this.settings,
    this.setupLaborMinutes = 0,
    this.perPlateLaborMinutes = 0,
    this.perUnitFinishingMinutes = 0,
    this.perUnitPackagingMicros = 0,
    this.orderPackagingMicros = 0,
    this.shippingMicros = 0,
    this.extras = const [],
  });

  final ParsedPrintProject project;
  final Map<String, MaterialProfile> materialProfiles;
  final PrinterProfile printer;
  final PricingSettings settings;
  final int setupLaborMinutes;
  final int perPlateLaborMinutes;
  final int perUnitFinishingMinutes;
  final int perUnitPackagingMicros;
  final int orderPackagingMicros;
  final int shippingMicros;
  final List<ExtraCost> extras;
}

class MaterialCostLine {
  const MaterialCostLine({
    required this.plateId,
    required this.profileId,
    required this.toolIndex,
    required this.massMg,
    required this.costMicros,
  });

  final String plateId;
  final String profileId;
  final int toolIndex;
  final int massMg;
  final int costMicros;
}

class PriceBreakdown {
  const PriceBreakdown({
    required this.materialLines,
    required this.materialMicros,
    required this.electricityMicros,
    required this.machineMicros,
    required this.failureReserveMicros,
    required this.laborMicros,
    required this.extrasMicros,
    required this.packagingMicros,
    required this.shippingMicros,
    required this.totalCostMicros,
    required this.calculatedPreTaxPriceMicros,
    required this.minimumFloorAdjustmentMicros,
    required this.preTaxPriceMicros,
    required this.platformFeeMicros,
    required this.taxMicros,
    required this.finalPriceMicros,
    required this.netProfitMicros,
    required this.effectiveMarginBasisPoints,
    required this.profitPerPrinterHourMicros,
    required this.totalDurationSeconds,
    required this.totalPlateRuns,
    required this.finishedUnits,
  });

  final List<MaterialCostLine> materialLines;
  final int materialMicros;
  final int electricityMicros;
  final int machineMicros;
  final int failureReserveMicros;
  final int laborMicros;
  final int extrasMicros;
  final int packagingMicros;
  final int shippingMicros;
  final int totalCostMicros;
  final int calculatedPreTaxPriceMicros;
  final int minimumFloorAdjustmentMicros;
  final int preTaxPriceMicros;
  final int platformFeeMicros;
  final int taxMicros;
  final int finalPriceMicros;
  final int netProfitMicros;
  final int effectiveMarginBasisPoints;
  final int profitPerPrinterHourMicros;
  final int totalDurationSeconds;
  final int totalPlateRuns;
  final int finishedUnits;

  bool get minimumFloorApplied => minimumFloorAdjustmentMicros > 0;
}
