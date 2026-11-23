import 'dart:math' as math;

class SavedColorProfile {
  const SavedColorProfile({
    required this.id,
    required this.name,
    required this.hex,
  });

  final String id;
  final String name;
  final String hex;
}

class PerceptualColorMatch {
  const PerceptualColorMatch({
    required this.profile,
    required this.deltaE,
    required this.confidenceBasisPoints,
  });

  final SavedColorProfile profile;
  final double deltaE;
  final int confidenceBasisPoints;

  bool get requiresConfirmation => deltaE > 12;
}

class PerceptualColorMatcher {
  const PerceptualColorMatcher();

  PerceptualColorMatch? nearest(
    String sampledHex,
    Iterable<SavedColorProfile> profiles,
  ) {
    final source = _lab(sampledHex);
    PerceptualColorMatch? best;
    for (final profile in profiles) {
      final target = _lab(profile.hex);
      final distance = math.sqrt(
        math.pow(source.$1 - target.$1, 2) +
            math.pow(source.$2 - target.$2, 2) +
            math.pow(source.$3 - target.$3, 2),
      );
      final confidence = ((1 - (distance / 50).clamp(0, 1)) * 10000).round();
      final candidate = PerceptualColorMatch(
        profile: profile,
        deltaE: distance,
        confidenceBasisPoints: confidence,
      );
      if (best == null || candidate.deltaE < best.deltaE) best = candidate;
    }
    return best;
  }

  (double, double, double) _lab(String hex) {
    final normalized = hex.replaceFirst('#', '');
    if (!RegExp(r'^[0-9a-fA-F]{6}$').hasMatch(normalized)) {
      throw FormatException('Invalid RGB color: $hex');
    }
    var red = int.parse(normalized.substring(0, 2), radix: 16) / 255;
    var green = int.parse(normalized.substring(2, 4), radix: 16) / 255;
    var blue = int.parse(normalized.substring(4, 6), radix: 16) / 255;
    double linear(double value) => value > 0.04045
        ? math.pow((value + 0.055) / 1.055, 2.4).toDouble()
        : value / 12.92;
    red = linear(red);
    green = linear(green);
    blue = linear(blue);
    var x = (red * 0.4124 + green * 0.3576 + blue * 0.1805) / 0.95047;
    var y = red * 0.2126 + green * 0.7152 + blue * 0.0722;
    var z = (red * 0.0193 + green * 0.1192 + blue * 0.9505) / 1.08883;
    double pivot(double value) => value > 0.008856
        ? math.pow(value, 1 / 3).toDouble()
        : 7.787 * value + 16 / 116;
    x = pivot(x);
    y = pivot(y);
    z = pivot(z);
    return (116 * y - 16, 500 * (x - y), 200 * (y - z));
  }
}
