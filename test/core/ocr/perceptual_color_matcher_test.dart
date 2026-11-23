import 'package:filarithm/core/ocr/perceptual_color_matcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('matches a sampled swatch in perceptual Lab space', () {
    const matcher = PerceptualColorMatcher();
    final match = matcher.nearest('#F56BAA', const [
      SavedColorProfile(id: 'pink', name: 'Pink PLA', hex: '#FF69B4'),
      SavedColorProfile(id: 'black', name: 'Black PLA', hex: '#101010'),
    ]);
    expect(match?.profile.id, 'pink');
    expect(match?.requiresConfirmation, isFalse);
  });
}
