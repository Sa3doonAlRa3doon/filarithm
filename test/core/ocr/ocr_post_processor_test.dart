import 'package:filarithm/core/ocr/ocr_post_processor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const processor = OcrPostProcessor();

  test('extracts slicer time and multiple weights', () {
    final result = processor.parse(
      'Print time 2h 15m 30s\nPink 45.2 g\nBlack 10,8 grams',
    );
    expect(result.durationSeconds, 8130);
    expect(result.weightsMg, [45200, 10800]);
    expect(result.needsConfirmation, isFalse);
  });

  test('supports clock duration and forces review when weight is absent', () {
    final result = processor.parse('Estimated 01:05:30');
    expect(result.durationSeconds, 3930);
    expect(result.weightsMg, isEmpty);
    expect(result.needsConfirmation, isTrue);
  });
}
