import 'dart:io';

import 'package:filarithm/core/ocr/ocr_post_processor.dart';
import 'package:filarithm/core/ocr/offline_ocr_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as image;

void main() {
  test(
    'Tesseract reads slicer values across the preprocessing image matrix',
    () async {
      final temporaryDirectory = await Directory.systemTemp.createTemp(
        'filarithm_ocr_matrix_',
      );
      addTearDown(() => temporaryDirectory.delete(recursive: true));
      final service = OfflineOcrService(
        temporaryDirectoryProvider: () async => temporaryDirectory,
      );
      const postProcessor = OcrPostProcessor();
      final cases = <_OcrMatrixCase>[
        _OcrMatrixCase('light', _fixture()),
        _OcrMatrixCase('dark', _fixture(dark: true)),
        _OcrMatrixCase(
          'rotation',
          image.copyRotate(_fixture(), angle: 90),
          options: const OcrPreprocessOptions(rotationDegrees: -90),
        ),
        _OcrMatrixCase('glare', _fixture(glare: true)),
        _OcrMatrixCase('resolution', image.copyResize(_fixture(), width: 720)),
        _OcrMatrixCase('ui-scale', image.copyResize(_fixture(), width: 1440)),
      ];

      for (final fixture in cases) {
        final source = File(
          '${temporaryDirectory.path}${Platform.pathSeparator}${fixture.name}.png',
        );
        await source.writeAsBytes(image.encodePng(fixture.source));
        final recognized = await service.recognize(
          source.path,
          options: fixture.options,
        );
        final parsed = postProcessor.parse(recognized);
        expect(
          parsed.durationSeconds,
          8130,
          reason: '${fixture.name} OCR output: $recognized',
        );
        expect(
          parsed.weightsMg,
          contains(45200),
          reason: '${fixture.name} OCR output: $recognized',
        );
      }
    },
    skip: !Platform.isLinux
        ? 'The production Tesseract process is exercised by Ubuntu CI.'
        : false,
    timeout: const Timeout(Duration(minutes: 2)),
  );
}

image.Image _fixture({bool dark = false, bool glare = false}) {
  final background = dark
      ? image.ColorRgb8(30, 34, 40)
      : image.ColorRgb8(250, 250, 250);
  final foreground = dark
      ? image.ColorRgb8(245, 245, 245)
      : image.ColorRgb8(20, 20, 20);
  final canvas = image.Image(width: 1100, height: 360);
  image.fill(canvas, color: background);
  image.drawString(
    canvas,
    'Print time 2h 15m 30s',
    font: image.arial48,
    x: 55,
    y: 65,
    color: foreground,
  );
  image.drawString(
    canvas,
    'Filament 45.2 g',
    font: image.arial48,
    x: 55,
    y: 175,
    color: foreground,
  );
  if (glare) {
    image.fillRect(
      canvas,
      x1: 850,
      y1: 0,
      x2: 1099,
      y2: 359,
      color: image.ColorRgba8(255, 255, 255, 205),
      alphaBlend: true,
    );
  }
  return canvas;
}

class _OcrMatrixCase {
  const _OcrMatrixCase(
    this.name,
    this.source, {
    this.options = const OcrPreprocessOptions(),
  });

  final String name;
  final image.Image source;
  final OcrPreprocessOptions options;
}
