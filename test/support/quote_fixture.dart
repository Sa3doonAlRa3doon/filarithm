import 'dart:typed_data';

import 'package:filarithm/core/domain/pricing_models.dart';
import 'package:filarithm/core/domain/print_project.dart';
import 'package:filarithm/core/pricing/pricing_engine.dart';
import 'package:filarithm/core/quote/pdf_quote_service.dart';
import 'package:image/image.dart' as image;

Uint8List _fixtureLogo() {
  final logo = image.Image(width: 32, height: 32);
  image.fill(logo, color: image.ColorRgb8(255, 107, 87));
  image.fillRect(
    logo,
    x1: 8,
    y1: 8,
    x2: 23,
    y2: 23,
    color: image.ColorRgb8(16, 25, 43),
  );
  return Uint8List.fromList(image.encodePng(logo));
}

QuoteDocumentData bilingualQuoteFixture({
  int taxBasisPoints = 500,
  String? trn = '100000000000001',
  bool itemizeByPlate = true,
}) {
  const project = ParsedPrintProject(
    sourceName: 'bracket.3mf',
    slicer: SlicerKind.crealityPrint,
    plates: [
      PlateEstimate(
        id: 'plate-1',
        name: 'Pink brackets',
        durationSeconds: 3600,
        unitsPerRun: 2,
        plateRuns: 2,
        materials: [
          MaterialConsumption(
            toolIndex: 0,
            modelMassMg: 44000,
            purgeMassMg: 6000,
            materialProfileId: 'pink',
          ),
        ],
      ),
      PlateEstimate(
        id: 'plate-2',
        name: 'Black hardware cover',
        durationSeconds: 1800,
        unitsPerRun: 1,
        materials: [
          MaterialConsumption(
            toolIndex: 0,
            modelMassMg: 9000,
            purgeMassMg: 1000,
            materialProfileId: 'black',
          ),
        ],
      ),
    ],
  );
  final input = PricingInput(
    project: project,
    materialProfiles: const {
      'pink': MaterialProfile(
        id: 'pink',
        name: 'Pink PLA',
        materialType: 'PLA',
        colorHex: '#FF69B4',
        spoolPriceMicros: 100000000,
        nominalMassMg: 1000000,
      ),
      'black': MaterialProfile(
        id: 'black',
        name: 'Black PLA',
        materialType: 'PLA',
        colorHex: '#000000',
        spoolPriceMicros: 90000000,
        nominalMassMg: 1000000,
      ),
    },
    printer: const PrinterProfile(
      id: 'printer',
      name: 'Printer',
      watts: 200,
      machineRateMicrosPerHour: 5000000,
    ),
    settings: PricingSettings(
      electricityRateMicrosPerKwh: 300000,
      laborRateMicrosPerHour: 30000000,
      failureAllowanceBasisPoints: 1000,
      targetMarginBasisPoints: 3500,
      platformFeeBasisPoints: 0,
      platformFixedFeeMicros: 0,
      taxBasisPoints: taxBasisPoints,
      minimumOrderMicros: 125000000,
    ),
    setupLaborMinutes: 10,
    perPlateLaborMinutes: 2,
    perUnitFinishingMinutes: 1,
    perUnitPackagingMicros: 250000,
    orderPackagingMicros: 2000000,
    shippingMicros: 15000000,
    extras: const [
      ExtraCost(
        name: 'Heat-set inserts',
        unitCostMicros: 500000,
        scope: CostScope.finishedUnit,
        laborMinutes: 1,
      ),
    ],
  );
  return QuoteDocumentData(
    quoteNumber: 'AVX-2026-0001',
    project: project,
    price: const PricingEngine().calculate(input),
    customerName: 'Saeed',
    issuedAt: DateTime.utc(2026, 11, 23),
    trn: trn,
    turnaround: '3 working days',
    taxBasisPoints: taxBasisPoints,
    termsEnglish: 'Valid for 14 days. 50% deposit before production.',
    termsArabic: 'العرض صالح لمدة 14 يوماً. دفعة 50% قبل بدء الإنتاج.',
    itemizeByPlate: itemizeByPlate,
    logoBytes: _fixtureLogo(),
  );
}

Future<Uint8List> buildBilingualQuoteFixture({
  int taxBasisPoints = 500,
  String? trn = '100000000000001',
  bool itemizeByPlate = true,
}) => const PdfQuoteService().build(
  bilingualQuoteFixture(
    taxBasisPoints: taxBasisPoints,
    trn: trn,
    itemizeByPlate: itemizeByPlate,
  ),
);
