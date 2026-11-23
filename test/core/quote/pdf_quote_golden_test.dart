import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as image;

import '../../support/quote_fixture.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('matches the rendered bilingual page golden', () async {
    final directory = await Directory.systemTemp.createTemp(
      'filarithm-pdf-golden-',
    );
    try {
      final pdf = File('${directory.path}${Platform.pathSeparator}quote.pdf');
      final prefix = '${directory.path}${Platform.pathSeparator}page';
      await pdf.writeAsBytes(await buildBilingualQuoteFixture(), flush: true);
      final render = await Process.run('pdftoppm', [
        '-f',
        '1',
        '-l',
        '1',
        '-singlefile',
        '-png',
        '-r',
        '96',
        pdf.path,
        prefix,
      ]);
      expect(render.exitCode, 0, reason: 'pdftoppm failed: ${render.stderr}');

      final rendered = File('$prefix.png');
      final golden = File('test/goldens/bilingual_quote_page1.png');
      if (Platform.environment['UPDATE_FILARITHM_GOLDENS'] == '1') {
        await golden.parent.create(recursive: true);
        await rendered.copy(golden.path);
      }

      expect(golden.existsSync(), isTrue, reason: 'Golden image is missing.');
      final actualImage = image.decodePng(await rendered.readAsBytes());
      final goldenImage = image.decodePng(await golden.readAsBytes());
      expect(actualImage, isNotNull);
      expect(goldenImage, isNotNull);
      expect(actualImage!.width, goldenImage!.width);
      expect(actualImage.height, goldenImage.height);

      final actualSmall = image.copyResize(actualImage, width: 96, height: 136);
      final goldenSmall = image.copyResize(goldenImage, width: 96, height: 136);
      var channelDifference = 0.0;
      for (var y = 0; y < actualSmall.height; y++) {
        for (var x = 0; x < actualSmall.width; x++) {
          final actual = actualSmall.getPixel(x, y);
          final expected = goldenSmall.getPixel(x, y);
          channelDifference += (actual.r - expected.r).abs();
          channelDifference += (actual.g - expected.g).abs();
          channelDifference += (actual.b - expected.b).abs();
        }
      }
      final meanDifference =
          channelDifference / (actualSmall.width * actualSmall.height * 3);
      expect(
        meanDifference,
        lessThan(5.0),
        reason:
            'Rendered PDF drifted from the approved bilingual golden. Mean channel difference: ${math.max(0, meanDifference).toStringAsFixed(3)}',
      );
    } finally {
      await directory.delete(recursive: true);
    }
  });
}
