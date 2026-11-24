import 'dart:convert';
import 'dart:io';

import 'package:filarithm/core/quote/pdf_quote_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/quote_fixture.dart';

Future<String?> extractPdfText(File pdf, File output) async {
  try {
    final extract = await Process.run('pdftotext', [
      '-layout',
      pdf.path,
      output.path,
    ]);
    expect(extract.exitCode, 0, reason: 'pdftotext failed: ${extract.stderr}');
    return await output.readAsString();
  } on ProcessException {
    if (Platform.isWindows) return null;
    rethrow;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('renders a shaped bilingual PDF with a valid PDF header', () async {
    final bytes = await buildBilingualQuoteFixture();

    expect(bytes.length, greaterThan(10000));
    expect(ascii.decode(bytes.take(4).toList()), '%PDF');
  });

  test('protects tax-invoice wording behind both VAT and TRN', () {
    expect(bilingualQuoteFixture().isTaxInvoice, isTrue);
    expect(bilingualQuoteFixture(trn: null).isTaxInvoice, isFalse);
    expect(bilingualQuoteFixture(taxBasisPoints: 0).isTaxInvoice, isFalse);
  });

  test('builds a WhatsApp-ready bilingual summary with Western numerals', () {
    final data = bilingualQuoteFixture();
    final summary = const PdfQuoteService().shareSummary(data);

    expect(summary, contains('Quote: AVX-2026-0001'));
    expect(summary, contains('Total: 131.25 AED'));
    expect(summary, contains('Turnaround: 3 working days'));
    expect(summary, contains('رقم العرض: AVX-2026-0001'));
    expect(summary, contains('الإجمالي: 131.25 AED'));
    expect(summary, isNot(contains('١٣١')));
  });

  test('preserves searchable mixed-script cells and pricing details', () async {
    final directory = await Directory.systemTemp.createTemp(
      'filarithm-pdf-text-',
    );
    try {
      final pdf = File('${directory.path}${Platform.pathSeparator}quote.pdf');
      final text = File('${directory.path}${Platform.pathSeparator}quote.txt');
      await pdf.writeAsBytes(await buildBilingualQuoteFixture(), flush: true);
      final extracted = await extractPdfText(pdf, text);
      if (extracted == null) return;

      expect(extracted, contains('3D PRINTING TAX INVOICE'));
      expect(extracted, contains('AVX-2026-0001'));
      expect(extracted, contains('Pink brackets'));
      expect(extracted, contains('Black hardware cover'));
      expect(extracted, contains('Minimum-order adjustment'));
      expect(extracted, contains('125.00 AED'));
      expect(extracted, contains('131.25 AED'));
      expect(extracted, contains('100000000000001'));
      expect(extracted, contains('الإجمالي'));
      expect(extracted, contains('العرض صالح'));
    } finally {
      await directory.delete(recursive: true);
    }
  });

  test(
    'uses quotation wording when VAT or TRN requirements are incomplete',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'filarithm-pdf-quotation-',
      );
      try {
        final pdf = File('${directory.path}${Platform.pathSeparator}quote.pdf');
        final text = File(
          '${directory.path}${Platform.pathSeparator}quote.txt',
        );
        await pdf.writeAsBytes(
          await buildBilingualQuoteFixture(trn: null),
          flush: true,
        );
        final extracted = await extractPdfText(pdf, text);
        if (extracted == null) return;

        expect(extracted, contains('3D PRINTING QUOTATION'));
        expect(extracted, isNot(contains('3D PRINTING TAX INVOICE')));
      } finally {
        await directory.delete(recursive: true);
      }
    },
  );

  test('renders combined material and time mode without plate rows', () async {
    final directory = await Directory.systemTemp.createTemp(
      'filarithm-pdf-combined-',
    );
    try {
      final pdf = File('${directory.path}${Platform.pathSeparator}quote.pdf');
      final text = File('${directory.path}${Platform.pathSeparator}quote.txt');
      await pdf.writeAsBytes(
        await buildBilingualQuoteFixture(itemizeByPlate: false),
        flush: true,
      );
      final extracted = await extractPdfText(pdf, text);
      if (extracted == null) return;

      expect(extracted, contains('2.50 h'));
      expect(extracted, contains('5'));
      expect(extracted, contains('97.00'));
      expect(extracted, contains('13.00'));
      expect(extracted, isNot(contains('Pink brackets')));
      expect(extracted, isNot(contains('Black hardware cover')));
    } finally {
      await directory.delete(recursive: true);
    }
  });
}
