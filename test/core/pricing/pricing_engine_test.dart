import 'package:filarithm/core/domain/pricing_models.dart';
import 'package:filarithm/core/domain/print_project.dart';
import 'package:filarithm/core/pricing/pricing_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const pink = MaterialProfile(
    id: 'pink',
    name: 'Pink PLA',
    materialType: 'PLA',
    colorHex: '#FF69B4',
    spoolPriceMicros: 100000000,
    nominalMassMg: 1000000,
  );
  const black = MaterialProfile(
    id: 'black',
    name: 'Black PLA',
    materialType: 'PLA',
    colorHex: '#101010',
    spoolPriceMicros: 90000000,
    nominalMassMg: 1000000,
  );
  const printer = PrinterProfile(
    id: 'sparkx',
    name: 'SPARKX i7',
    watts: 200,
    machineRateMicrosPerHour: 5000000,
  );

  PricingInput input({
    int pinkModelMg = 100000,
    int pinkPurgeMg = 10000,
    int blackModelMg = 50000,
    int blackPurgeMg = 5000,
    int runs = 2,
    int unitsPerRun = 3,
    int minimumOrderMicros = 0,
    int targetMarginBps = 3000,
    int platformFeeBps = 500,
    int taxBps = 500,
  }) {
    return PricingInput(
      project: ParsedPrintProject(
        sourceName: 'fixture.3mf',
        slicer: SlicerKind.orcaSlicer,
        plates: [
          PlateEstimate(
            id: 'plate-1',
            name: 'Plate 1',
            durationSeconds: 7200,
            plateRuns: runs,
            unitsPerRun: unitsPerRun,
            materials: [
              MaterialConsumption(
                toolIndex: 0,
                modelMassMg: pinkModelMg,
                purgeMassMg: pinkPurgeMg,
                materialProfileId: pink.id,
              ),
              MaterialConsumption(
                toolIndex: 1,
                modelMassMg: blackModelMg,
                purgeMassMg: blackPurgeMg,
                materialProfileId: black.id,
              ),
            ],
          ),
        ],
      ),
      materialProfiles: const {'pink': pink, 'black': black},
      printer: printer,
      settings: PricingSettings(
        electricityRateMicrosPerKwh: 300000,
        laborRateMicrosPerHour: 30000000,
        failureAllowanceBasisPoints: 1000,
        targetMarginBasisPoints: targetMarginBps,
        platformFeeBasisPoints: platformFeeBps,
        platformFixedFeeMicros: 2000000,
        taxBasisPoints: taxBps,
        minimumOrderMicros: minimumOrderMicros,
      ),
      setupLaborMinutes: 15,
      perPlateLaborMinutes: 5,
      perUnitFinishingMinutes: 2,
      perUnitPackagingMicros: 500000,
      orderPackagingMicros: 1500000,
      shippingMicros: 10000000,
      extras: const [
        ExtraCost(
          name: 'Heat-set insert',
          unitCostMicros: 1000000,
          laborMinutes: 1,
          scope: CostScope.finishedUnit,
        ),
      ],
    );
  }

  test('prices multiple colours, purge, runs, units and scoped costs', () {
    final result = const PricingEngine().calculate(input());

    expect(result.totalDurationSeconds, 14400);
    expect(result.totalPlateRuns, 2);
    expect(result.finishedUnits, 6);
    expect(result.materialLines.map((line) => line.massMg), [220000, 110000]);
    expect(result.materialMicros, 31900000);
    expect(result.electricityMicros, 240000);
    expect(result.machineMicros, 20000000);
    expect(result.failureReserveMicros, 5214000);
    expect(result.laborMicros, 21500000);
    expect(result.extrasMicros, 6000000);
    expect(result.packagingMicros, 4500000);
    expect(result.shippingMicros, 10000000);
    expect(result.totalCostMicros, 99354000);
    expect(result.calculatedPreTaxPriceMicros, 155929231);
    expect(result.platformFeeMicros, 9796462);
    expect(result.taxMicros, 7796462);
    expect(result.finalPriceMicros, 163725693);
    expect(result.netProfitMicros, 46778769);
  });

  test('minimum order floor is applied before VAT', () {
    final result = const PricingEngine().calculate(
      input(
        pinkModelMg: 0,
        pinkPurgeMg: 0,
        blackModelMg: 0,
        blackPurgeMg: 0,
        runs: 0,
        minimumOrderMicros: 250000000,
      ),
    );

    expect(result.preTaxPriceMicros, 250000000);
    expect(result.minimumFloorApplied, isTrue);
    expect(result.taxMicros, 12500000);
    expect(result.finalPriceMicros, 262500000);
  });

  test('rejects impossible margin and platform percentage', () {
    expect(
      () => const PricingEngine().calculate(
        input(targetMarginBps: 9000, platformFeeBps: 1000),
      ),
      throwsFormatException,
    );
  });

  test('requires a confirmed material mapping', () {
    final original = input();
    final plate = original.project.plates.single;
    final mapped = plate.materials.first;
    final unmapped = MaterialConsumption(
      toolIndex: mapped.toolIndex,
      modelMassMg: mapped.modelMassMg,
      purgeMassMg: mapped.purgeMassMg,
    );
    final broken = PricingInput(
      project: ParsedPrintProject(
        sourceName: original.project.sourceName,
        slicer: original.project.slicer,
        plates: [
          plate.copyWith(materials: [unmapped]),
        ],
      ),
      materialProfiles: original.materialProfiles,
      printer: original.printer,
      settings: original.settings,
    );

    expect(
      () => const PricingEngine().calculate(broken),
      throwsFormatException,
    );
  });
}
