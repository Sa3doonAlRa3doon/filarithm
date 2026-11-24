import 'dart:io';

import 'package:flutter/services.dart';
import 'package:file_selector/file_selector.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_text_shaper/pdf_text_shaper.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/pricing_models.dart';
import '../domain/print_project.dart';

class QuoteDocumentData {
  const QuoteDocumentData({
    required this.quoteNumber,
    required this.project,
    required this.price,
    this.customerName = 'Customer',
    this.businessName = 'AVEONEX',
    this.issuedAt,
    this.trn,
    this.turnaround = 'To be confirmed',
    this.taxBasisPoints = 0,
    this.termsEnglish = 'Quotation validity and payment terms to be agreed.',
    this.termsArabic = 'تُحدد صلاحية العرض وشروط الدفع بالاتفاق.',
    this.itemizeByPlate = true,
    this.logoBytes,
  });

  final String quoteNumber;
  final ParsedPrintProject project;
  final PriceBreakdown price;
  final String customerName;
  final String businessName;
  final DateTime? issuedAt;
  final String? trn;
  final String turnaround;
  final int taxBasisPoints;
  final String termsEnglish;
  final String termsArabic;
  final bool itemizeByPlate;
  final Uint8List? logoBytes;

  bool get isTaxInvoice =>
      taxBasisPoints > 0 && trn != null && trn!.trim().isNotEmpty;
}

class PdfQuoteService {
  const PdfQuoteService();

  static const _shareChannel = MethodChannel('ae.aveonex.filarithm/share');

  Future<Uint8List> build(QuoteDocumentData data) async {
    final latinBytes = await rootBundle.load(
      'assets/fonts/IBMPlexSans-Regular.ttf',
    );
    final latinBoldBytes = await rootBundle.load(
      'assets/fonts/IBMPlexSans-Bold.ttf',
    );
    final arabicBytes = await rootBundle.load(
      'assets/fonts/IBMPlexSansArabic-Regular.ttf',
    );
    final arabicBoldBytes = await rootBundle.load(
      'assets/fonts/IBMPlexSansArabic-Bold.ttf',
    );
    final latin = pw.Font.ttf(latinBytes);
    final latinBold = pw.Font.ttf(latinBoldBytes);
    final arabic = ShapedFont.fromBytes(
      arabicBytes.buffer.asUint8List(),
      name: 'IBM Plex Sans Arabic',
    );
    final arabicBold = ShapedFont.fromBytes(
      arabicBoldBytes.buffer.asUint8List(),
      name: 'IBM Plex Sans Arabic Bold',
    );
    final searchableArabicFont = pw.Font.ttf(arabicBytes);
    final document = pw.Document(
      title: '${data.quoteNumber} - Filarithm by AVEONEX',
      author: data.businessName,
      creator: 'Filarithm by AVEONEX',
    );
    final coral = PdfColor.fromHex('#FF6B57');
    final navy = PdfColor.fromHex('#10192B');
    final pale = PdfColor.fromHex('#F3F6FA');
    final titleEnglish = data.isTaxInvoice
        ? '3D PRINTING TAX INVOICE'
        : '3D PRINTING QUOTATION';
    final titleArabic = data.isTaxInvoice
        ? 'فاتورة ضريبية للطباعة ثلاثية الأبعاد'
        : 'عرض سعر للطباعة ثلاثية الأبعاد';

    try {
      document.addPage(
        pw.MultiPage(
          theme: pw.ThemeData.withFont(base: latin, bold: latinBold),
          margin: const pw.EdgeInsets.all(32),
          header: (_) => pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      if (data.logoBytes != null)
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 5),
                          child: pw.Image(
                            pw.MemoryImage(data.logoBytes!),
                            height: 30,
                          ),
                        ),
                      pw.Text(
                        data.businessName,
                        style: pw.TextStyle(
                          font: latinBold,
                          fontSize: 24,
                          color: coral,
                        ),
                      ),
                      pw.Text(
                        titleEnglish,
                        style: pw.TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.5,
                          color: navy,
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      ShapedText(
                        titleArabic,
                        style: ShapedTextStyle(
                          font: arabicBold,
                          fontSize: 15,
                          color: navy,
                          direction: ShapedTextDirection.rightToLeft,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        data.quoteNumber,
                        style: pw.TextStyle(font: latinBold, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Divider(color: coral, thickness: 2),
            ],
          ),
          footer: (context) => pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Generated offline by Filarithm',
                style: const pw.TextStyle(
                  fontSize: 8,
                  color: PdfColors.grey700,
                ),
              ),
              pw.Text(
                '${context.pageNumber} / ${context.pagesCount}',
                style: const pw.TextStyle(
                  fontSize: 8,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
          build: (_) => [
            pw.SizedBox(height: 12),
            _bilingualInfoRow(
              latinBold,
              arabicBold,
              'Customer',
              'العميل',
              data.customerName,
            ),
            _bilingualInfoRow(
              latinBold,
              arabicBold,
              'Date',
              'التاريخ',
              _date(data.issuedAt ?? DateTime.now()),
            ),
            _bilingualInfoRow(
              latinBold,
              arabicBold,
              'Turnaround',
              'مدة التنفيذ',
              data.turnaround,
            ),
            if (data.trn != null && data.trn!.trim().isNotEmpty)
              _bilingualInfoRow(
                latinBold,
                arabicBold,
                'TRN',
                'الرقم الضريبي',
                data.trn!,
              ),
            pw.SizedBox(height: 22),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: pale,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        data.project.sourceName,
                        style: pw.TextStyle(font: latinBold, fontSize: 13),
                      ),
                      pw.Text(
                        '${data.project.slicer.name} · ${data.project.plates.length} plate(s)',
                        style: const pw.TextStyle(
                          fontSize: 9,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        '${(data.price.totalDurationSeconds / 3600).toStringAsFixed(1)} h',
                        style: pw.TextStyle(font: latinBold),
                      ),
                      pw.Text(
                        '${data.price.finishedUnits} unit(s)',
                        style: const pw.TextStyle(
                          fontSize: 9,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 18),
            if (data.itemizeByPlate)
              _plateTable(latinBold, arabicBold, data.project),
            if (!data.itemizeByPlate)
              _combinedTable(latinBold, arabicBold, data.project),
            pw.SizedBox(height: 18),
            pw.Table(
              border: pw.TableBorder(
                horizontalInside: const pw.BorderSide(color: PdfColors.grey300),
              ),
              columnWidths: const {
                0: pw.FlexColumnWidth(3),
                1: pw.FlexColumnWidth(1.4),
              },
              children: [
                _priceRow(
                  latinBold,
                  arabicBold,
                  'Production cost',
                  'تكلفة الإنتاج',
                  data.price.totalCostMicros,
                ),
                _priceRow(
                  latinBold,
                  arabicBold,
                  'Platform fees',
                  'رسوم المنصة',
                  data.price.platformFeeMicros,
                ),
                if (data.price.minimumFloorApplied)
                  _priceRow(
                    latinBold,
                    arabicBold,
                    'Minimum-order adjustment',
                    'تعديل الحد الأدنى للطلب',
                    data.price.minimumFloorAdjustmentMicros,
                  ),
                _priceRow(
                  latinBold,
                  arabicBold,
                  'Price before VAT',
                  'السعر قبل الضريبة',
                  data.price.preTaxPriceMicros,
                ),
                if (data.taxBasisPoints > 0)
                  _priceRow(
                    latinBold,
                    arabicBold,
                    'VAT ${(data.taxBasisPoints / 100).toStringAsFixed(data.taxBasisPoints % 100 == 0 ? 0 : 2)}%',
                    'ضريبة القيمة المضافة',
                    data.price.taxMicros,
                  ),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              color: navy,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'TOTAL',
                        style: pw.TextStyle(
                          font: latinBold,
                          color: PdfColors.white,
                          fontSize: 12,
                        ),
                      ),
                      ShapedText(
                        'الإجمالي',
                        style: ShapedTextStyle(
                          font: arabicBold,
                          color: PdfColors.white,
                          fontSize: 12,
                          direction: ShapedTextDirection.rightToLeft,
                        ),
                      ),
                    ],
                  ),
                  pw.Text(
                    '${_money(data.price.finalPriceMicros)} AED',
                    style: pw.TextStyle(
                      font: latinBold,
                      color: PdfColors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 18),
            pw.Text(
              'Terms',
              style: pw.TextStyle(font: latinBold, fontSize: 10),
            ),
            pw.Text(data.termsEnglish, style: const pw.TextStyle(fontSize: 9)),
            pw.SizedBox(height: 3),
            ShapedText(
              'الشروط',
              style: ShapedTextStyle(
                font: arabicBold,
                fontSize: 10,
                direction: ShapedTextDirection.rightToLeft,
              ),
            ),
            ShapedText(
              data.termsArabic,
              style: ShapedTextStyle(
                font: arabic,
                fontSize: 9,
                direction: ShapedTextDirection.rightToLeft,
              ),
            ),
            pw.SizedBox(height: 18),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Thank you for choosing AVEONEX.',
                  style: const pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.grey700,
                  ),
                ),
                ShapedText(
                  'شكراً لاختياركم أفيو نيكس',
                  style: ShapedTextStyle(
                    font: arabic,
                    fontSize: 10,
                    color: PdfColors.grey700,
                    direction: ShapedTextDirection.rightToLeft,
                  ),
                ),
              ],
            ),
            // HarfBuzz draws contextual Arabic glyphs in visual order. Keep a
            // transparent logical-order layer as well so copy, search, and PDF
            // accessibility tools recover the original Unicode text rather
            // than the visually reversed glyph sequence.
            pw.Opacity(
              opacity: 0,
              child: pw.Column(
                children: [
                  pw.Text(
                    _searchableArabicText(data, titleArabic),
                    style: pw.TextStyle(
                      font: searchableArabicFont,
                      fontSize: 0.1,
                    ),
                    textDirection: pw.TextDirection.ltr,
                    maxLines: 1,
                  ),
                  // Poppler releases disagree on whether an invisible RTL run
                  // should be returned in content order or visual order. The
                  // mirrored run makes the logical Unicode text searchable in
                  // both behaviors while remaining fully transparent.
                  pw.Text(
                    _reverseRunes(_searchableArabicText(data, titleArabic)),
                    style: pw.TextStyle(
                      font: searchableArabicFont,
                      fontSize: 0.1,
                    ),
                    textDirection: pw.TextDirection.ltr,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      return Uint8List.fromList(await document.save());
    } finally {
      arabic.dispose();
      arabicBold.dispose();
    }
  }

  Future<File> buildTemporaryFile(QuoteDocumentData data) async {
    final directory = await getTemporaryDirectory();
    final file = File(path.join(directory.path, '${data.quoteNumber}.pdf'));
    await file.writeAsBytes(await build(data), flush: true);
    return file;
  }

  Future<void> share(QuoteDocumentData data) async {
    final file = await buildTemporaryFile(data);
    final summary = shareSummary(data);
    if (Platform.isAndroid) {
      try {
        final shared = await _shareChannel.invokeMethod<bool>('shareWhatsApp', {
          'filePath': file.path,
          'text': summary,
        });
        if (shared == true) return;
      } on PlatformException {
        // Fall through to the platform share sheet.
      }
    }
    await SharePlus.instance.share(
      ShareParams(
        title: '${data.quoteNumber} · AVEONEX',
        subject: '3D print quotation ${data.quoteNumber}',
        text: summary,
        files: [XFile(file.path, mimeType: 'application/pdf')],
      ),
    );
  }

  Future<File?> save(QuoteDocumentData data) async {
    final location = await getSaveLocation(
      suggestedName: '${data.quoteNumber}.pdf',
      acceptedTypeGroups: const [
        XTypeGroup(label: 'PDF quotation', extensions: ['pdf']),
      ],
    );
    if (location == null) return null;
    final file = File(location.path);
    await file.writeAsBytes(await build(data), flush: true);
    return file;
  }

  Future<void> open(QuoteDocumentData data) async {
    final file = await buildTemporaryFile(data);
    final result = await OpenFilex.open(file.path, type: 'application/pdf');
    if (result.type != ResultType.done) {
      throw StateError(result.message);
    }
  }

  Future<void> copySummary(QuoteDocumentData data) =>
      Clipboard.setData(ClipboardData(text: shareSummary(data)));

  String shareSummary(QuoteDocumentData data) =>
      '3D print quotation\nQuote: ${data.quoteNumber}\nCustomer: ${data.customerName}\nTotal: ${_money(data.price.finalPriceMicros)} AED\nTurnaround: ${data.turnaround}\n\nعرض سعر طباعة ثلاثية الأبعاد\nرقم العرض: ${data.quoteNumber}\nالعميل: ${data.customerName}\nالإجمالي: ${_money(data.price.finalPriceMicros)} AED\nمدة التنفيذ: ${data.turnaround}';

  String _searchableArabicText(QuoteDocumentData data, String titleArabic) =>
      '$titleArabic رقم العرض العميل التاريخ مدة التنفيذ الرقم الضريبي '
      'اللوحة مرات وحدات الوقت الوزن الإجمالي وزن المجسم وزن الهدر '
      'تكلفة الإنتاج رسوم المنصة تعديل الحد الأدنى للطلب السعر قبل الضريبة '
      'ضريبة القيمة المضافة الإجمالي الشروط ${data.termsArabic} '
      'شكراً لاختياركم أفيو نيكس';

  String _reverseRunes(String value) =>
      String.fromCharCodes(value.runes.toList().reversed);

  pw.Widget _bilingualInfoRow(
    pw.Font latinBold,
    ShapedFont arabicBold,
    String english,
    String arabic,
    String value,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 3),
    child: pw.Row(
      children: [
        pw.SizedBox(
          width: 88,
          child: pw.Text(
            english,
            style: pw.TextStyle(font: latinBold, fontSize: 9),
          ),
        ),
        pw.SizedBox(
          width: 88,
          child: ShapedText(
            arabic,
            style: ShapedTextStyle(
              font: arabicBold,
              fontSize: 9,
              direction: ShapedTextDirection.rightToLeft,
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            value,
            textAlign: pw.TextAlign.right,
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),
      ],
    ),
  );

  pw.TableRow _priceRow(
    pw.Font latinBold,
    ShapedFont arabicBold,
    String english,
    String arabic,
    int amount,
  ) => pw.TableRow(
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 9),
        child: pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                english,
                style: pw.TextStyle(font: latinBold, fontSize: 9),
              ),
            ),
            pw.Expanded(
              child: ShapedText(
                arabic,
                style: ShapedTextStyle(
                  font: arabicBold,
                  fontSize: 9,
                  direction: ShapedTextDirection.rightToLeft,
                ),
              ),
            ),
          ],
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 9),
        child: pw.Text(
          '${_money(amount)} AED',
          textAlign: pw.TextAlign.right,
          style: const pw.TextStyle(fontSize: 9),
        ),
      ),
    ],
  );

  pw.Widget _plateTable(
    pw.Font latinBold,
    ShapedFont arabicBold,
    ParsedPrintProject project,
  ) {
    final selected = project.plates.where((plate) => plate.selected).toList();
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      columnWidths: const {
        0: pw.FlexColumnWidth(2.2),
        1: pw.FlexColumnWidth(0.8),
        2: pw.FlexColumnWidth(0.8),
        3: pw.FlexColumnWidth(1.1),
        4: pw.FlexColumnWidth(1.1),
        5: pw.FlexColumnWidth(1.1),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _headerCell(latinBold, arabicBold, 'Plate', 'اللوحة'),
            _headerCell(latinBold, arabicBold, 'Runs', 'مرات'),
            _headerCell(latinBold, arabicBold, 'Units', 'وحدات'),
            _headerCell(latinBold, arabicBold, 'Time', 'الوقت'),
            _headerCell(
              latinBold,
              arabicBold,
              'Model/total g',
              'وزن المجسم/الإجمالي',
            ),
            _headerCell(latinBold, arabicBold, 'Purge g', 'وزن الهدر'),
          ],
        ),
        for (final plate in selected)
          pw.TableRow(
            children: [
              _valueCell(plate.name),
              _valueCell('${plate.plateRuns}'),
              _valueCell('${plate.finishedUnits}'),
              _valueCell(
                '${(plate.totalDurationSeconds / 3600).toStringAsFixed(2)} h',
              ),
              _valueCell(
                (plate.materials.fold<int>(
                          0,
                          (sum, material) =>
                              sum +
                              (material.reportedTotalMassMg ??
                                      material.modelMassMg) *
                                  plate.plateRuns,
                        ) /
                        1000)
                    .toStringAsFixed(2),
              ),
              _valueCell(
                (plate.materials.fold<int>(
                          0,
                          (sum, material) =>
                              sum + material.purgeMassMg * plate.plateRuns,
                        ) /
                        1000)
                    .toStringAsFixed(2),
              ),
            ],
          ),
      ],
    );
  }

  pw.Widget _combinedTable(
    pw.Font latinBold,
    ShapedFont arabicBold,
    ParsedPrintProject project,
  ) {
    final selected = project.plates.where((plate) => plate.selected).toList();
    final durationSeconds = selected.fold<int>(
      0,
      (sum, plate) => sum + plate.totalDurationSeconds,
    );
    final finishedUnits = selected.fold<int>(
      0,
      (sum, plate) => sum + plate.finishedUnits,
    );
    final modelOrTotalMassMg = selected.fold<int>(
      0,
      (plateSum, plate) =>
          plateSum +
          plate.materials.fold<int>(
                0,
                (sum, material) =>
                    sum +
                    (material.reportedTotalMassMg ?? material.modelMassMg),
              ) *
              plate.plateRuns,
    );
    final purgeMassMg = selected.fold<int>(
      0,
      (plateSum, plate) =>
          plateSum +
          plate.materials.fold<int>(
                0,
                (sum, material) => sum + material.purgeMassMg,
              ) *
              plate.plateRuns,
    );
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      columnWidths: const {
        0: pw.FlexColumnWidth(1.2),
        1: pw.FlexColumnWidth(1),
        2: pw.FlexColumnWidth(1.4),
        3: pw.FlexColumnWidth(1.1),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _headerCell(latinBold, arabicBold, 'Time', 'الوقت'),
            _headerCell(latinBold, arabicBold, 'Units', 'وحدات'),
            _headerCell(
              latinBold,
              arabicBold,
              'Model/total g',
              'وزن المجسم/الإجمالي',
            ),
            _headerCell(latinBold, arabicBold, 'Purge g', 'وزن الهدر'),
          ],
        ),
        pw.TableRow(
          children: [
            _valueCell('${(durationSeconds / 3600).toStringAsFixed(2)} h'),
            _valueCell('$finishedUnits'),
            _valueCell((modelOrTotalMassMg / 1000).toStringAsFixed(2)),
            _valueCell((purgeMassMg / 1000).toStringAsFixed(2)),
          ],
        ),
      ],
    );
  }

  pw.Widget _headerCell(
    pw.Font latinBold,
    ShapedFont arabicBold,
    String english,
    String arabic,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.all(5),
    child: pw.Column(
      children: [
        pw.Text(english, style: pw.TextStyle(font: latinBold, fontSize: 7)),
        ShapedText(
          arabic,
          style: ShapedTextStyle(
            font: arabicBold,
            fontSize: 7,
            direction: ShapedTextDirection.rightToLeft,
          ),
        ),
      ],
    ),
  );

  pw.Widget _valueCell(String value) => pw.Padding(
    padding: const pw.EdgeInsets.all(5),
    child: pw.Text(
      value,
      textAlign: pw.TextAlign.center,
      style: const pw.TextStyle(fontSize: 8),
    ),
  );

  static String _money(int micros) => (micros / 1000000).toStringAsFixed(2);
  static String _date(DateTime value) =>
      '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
