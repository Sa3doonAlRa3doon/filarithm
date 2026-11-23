import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as image;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class OcrPreprocessOptions {
  const OcrPreprocessOptions({
    this.rotationDegrees = 0,
    this.cropLeft = 0,
    this.cropTop = 0,
    this.cropRight = 0,
    this.cropBottom = 0,
    this.perspectiveTopInset = 0,
    this.maxWidth = 2200,
    this.contrast = 1.25,
  });

  final double rotationDegrees;
  final double cropLeft;
  final double cropTop;
  final double cropRight;
  final double cropBottom;
  final double perspectiveTopInset;
  final int maxWidth;
  final double contrast;
}

class OfflineOcrResult {
  const OfflineOcrResult({required this.text, required this.sampledHexColors});

  final String text;
  final List<String> sampledHexColors;
}

class OfflineOcrService {
  const OfflineOcrService({this.temporaryDirectoryProvider});

  /// Injectable so the preprocessing pipeline can be exercised without a
  /// platform-channel implementation in deterministic desktop tests.
  final Future<Directory> Function()? temporaryDirectoryProvider;

  String get engineName => Platform.isAndroid
      ? 'Google ML Kit (offline)'
      : 'Tesseract OCR (offline)';

  Future<String> recognize(
    String inputPath, {
    OcrPreprocessOptions options = const OcrPreprocessOptions(),
  }) async => (await recognizeDetailed(inputPath, options: options)).text;

  Future<OfflineOcrResult> recognizeDetailed(
    String inputPath, {
    OcrPreprocessOptions options = const OcrPreprocessOptions(),
  }) async {
    if (!Platform.isAndroid && !Platform.isLinux) {
      throw UnsupportedError(
        'Offline OCR is available on Android and Ubuntu Linux.',
      );
    }
    final prepared = await _prepare(inputPath, options);
    try {
      final text = Platform.isAndroid
          ? await _mlKit(prepared.file.path)
          : await _tesseract(prepared.file.path);
      return OfflineOcrResult(
        text: text,
        sampledHexColors: prepared.sampledHexColors,
      );
    } finally {
      if (await prepared.file.exists()) await prepared.file.delete();
    }
  }

  Future<String> _mlKit(String inputPath) async {
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      final result = await recognizer.processImage(
        InputImage.fromFilePath(inputPath),
      );
      return result.text;
    } finally {
      await recognizer.close();
    }
  }

  Future<String> _tesseract(String inputPath) async {
    final result = await Process.run('tesseract', [
      inputPath,
      'stdout',
      '-l',
      'eng',
      '--psm',
      '6',
    ]);
    if (result.exitCode != 0) {
      throw ProcessException(
        'tesseract',
        const [],
        result.stderr.toString().trim(),
        result.exitCode,
      );
    }
    return result.stdout.toString();
  }

  Future<_PreparedOcrImage> _prepare(
    String inputPath,
    OcrPreprocessOptions options,
  ) async {
    final source = await File(inputPath).readAsBytes();
    final decoded = image.decodeImage(source);
    if (decoded == null) {
      throw const FormatException('The selected image could not be decoded.');
    }
    var working = image.bakeOrientation(decoded);
    if (options.rotationDegrees != 0) {
      working = image.copyRotate(
        working,
        angle: options.rotationDegrees,
        interpolation: image.Interpolation.cubic,
      );
    }
    final left = (working.width * options.cropLeft.clamp(0.0, 0.45)).round();
    final top = (working.height * options.cropTop.clamp(0.0, 0.45)).round();
    final right = (working.width * options.cropRight.clamp(0.0, 0.45)).round();
    final bottom = (working.height * options.cropBottom.clamp(0.0, 0.45))
        .round();
    if (left + right < working.width - 2 &&
        top + bottom < working.height - 2 &&
        (left + top + right + bottom > 0)) {
      working = image.copyCrop(
        working,
        x: left,
        y: top,
        width: working.width - left - right,
        height: working.height - top - bottom,
      );
    }
    final inset = options.perspectiveTopInset.clamp(-0.4, 0.4);
    if (inset != 0) {
      final pixels = (working.width * inset.abs()).round();
      working = image.copyRectify(
        working,
        topLeft: image.Point(inset > 0 ? pixels : 0, 0),
        topRight: image.Point(
          inset < 0 ? working.width - 1 - pixels : working.width - 1,
          0,
        ),
        bottomLeft: image.Point(0, working.height - 1),
        bottomRight: image.Point(working.width - 1, working.height - 1),
        interpolation: image.Interpolation.linear,
      );
    }
    if (options.maxWidth > 0 && working.width > options.maxWidth) {
      working = image.copyResize(
        working,
        width: options.maxWidth,
        interpolation: image.Interpolation.cubic,
      );
    }
    final sampledHexColors = _sampleSwatches(working);
    final normalized = image.adjustColor(
      image.grayscale(working),
      contrast: options.contrast,
    );
    final directory =
        await (temporaryDirectoryProvider?.call() ?? getTemporaryDirectory());
    final normalizedFile = File(
      path.join(
        directory.path,
        'filarithm_ocr_${DateTime.now().microsecondsSinceEpoch}.png',
      ),
    );
    await normalizedFile.writeAsBytes(image.encodePng(normalized), flush: true);
    return _PreparedOcrImage(normalizedFile, sampledHexColors);
  }

  List<String> _sampleSwatches(image.Image source) {
    final preview = image.copyResize(
      source,
      width: 64,
      height: 64,
      interpolation: image.Interpolation.average,
    );
    final buckets = <int, int>{};
    for (final pixel in preview) {
      final red = pixel.r.toInt();
      final green = pixel.g.toInt();
      final blue = pixel.b.toInt();
      final maximum = [red, green, blue].reduce((a, b) => a > b ? a : b);
      final minimum = [red, green, blue].reduce((a, b) => a < b ? a : b);
      if (maximum - minimum < 32 || maximum < 40 || minimum > 235) continue;
      final key = ((red ~/ 32) << 6) | ((green ~/ 32) << 3) | (blue ~/ 32);
      buckets[key] = (buckets[key] ?? 0) + 1;
    }
    final ranked = buckets.entries.toList()
      ..sort((left, right) => right.value.compareTo(left.value));
    return [for (final entry in ranked.take(8)) _bucketHex(entry.key)];
  }

  String _bucketHex(int key) {
    final red = ((key >> 6) & 7) * 32 + 16;
    final green = ((key >> 3) & 7) * 32 + 16;
    final blue = (key & 7) * 32 + 16;
    final rgb = (red << 16) | (green << 8) | blue;
    return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}

class _PreparedOcrImage {
  const _PreparedOcrImage(this.file, this.sampledHexColors);

  final File file;
  final List<String> sampledHexColors;
}
