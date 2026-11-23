import 'dart:typed_data';

import 'package:filarithm/core/domain/pricing_models.dart';
import 'package:filarithm/core/domain/print_project.dart';
import 'package:filarithm/core/pricing/pricing_engine.dart';
import 'package:filarithm/core/quote/pdf_quote_service.dart';

Future<Uint8List> buildBilingualQuoteFixture() async {
  const project = ParsedPrintProject(
    sourceName: 'bracket.3mf',
    slicer: SlicerKind.crealityPrint,
    plates: [
      PlateEstimate(
        id: 'plate-1',
        name: 'Plate 1',
        durationSeconds: 3600,
        unitsPerRun: 2,
        materials: [
          MaterialConsumption(
            toolIndex: 0,
            modelMassMg: 44000,
            purgeMassMg: 6000,
            materialProfileId: 'pink',
          ),
        ],
      ),
    ],
  );
  const input = PricingInput(
    project: project,
    materialProfiles: {
      'pink': MaterialProfile(
        id: 'pink',
        name: 'Pink PLA',
        materialType: 'PLA',
        colorHex: '#FF69B4',
        spoolPriceMicros: 100000000,
        nominalMassMg: 1000000,
      ),
    },
    printer: PrinterProfile(
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
      taxBasisPoints: 500,
    ),
  );
  return const PdfQuoteService().build(
    QuoteDocumentData(
      quoteNumber: 'AVX-2026-0001',
      project: project,
      price: const PricingEngine().calculate(input),
      customerName: 'Saeed',
      issuedAt: DateTime.utc(2026, 11, 23),
      trn: '100000000000001',
      turnaround: '3 working days',
      taxBasisPoints: 500,
      termsEnglish: 'Valid for 14 days. 50% deposit before production.',
      termsArabic: 'العرض صالح لمدة 14 يوماً. دفعة 50% قبل بدء الإنتاج.',
    ),
  );
}
