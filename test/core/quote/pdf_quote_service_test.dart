import 'dart:convert';

import 'package:filarithm/core/domain/pricing_models.dart';
import 'package:filarithm/core/domain/print_project.dart';
import 'package:filarithm/core/pricing/pricing_engine.dart';
import 'package:filarithm/core/quote/pdf_quote_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('renders a shaped bilingual PDF with a valid PDF header', () async {
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
              reportedTotalMassMg: 50000,
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
    final bytes = await const PdfQuoteService().build(
      QuoteDocumentData(
        quoteNumber: 'AVX-2026-0001',
        project: project,
        price: const PricingEngine().calculate(input),
        customerName: 'Saeed',
        trn: '100000000000001',
      ),
    );

    expect(bytes.length, greaterThan(10000));
    expect(ascii.decode(bytes.take(4).toList()), '%PDF');
  });
}
