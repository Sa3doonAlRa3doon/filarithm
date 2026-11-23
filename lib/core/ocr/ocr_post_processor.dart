class OcrMaterialDetection {
  const OcrMaterialDetection({
    required this.toolIndex,
    required this.weightMg,
    required this.confidenceBasisPoints,
    required this.provenance,
    this.materialType,
    this.colorName,
    this.colorHex,
  });

  final int toolIndex;
  final int weightMg;
  final String? materialType;
  final String? colorName;
  final String? colorHex;
  final int confidenceBasisPoints;
  final String provenance;

  bool get hasResolvedColor => colorHex != null || colorName != null;
}

class OcrEstimate {
  const OcrEstimate({
    required this.rawText,
    required this.durationSeconds,
    required this.weightsMg,
    required this.confidenceBasisPoints,
    this.materials = const [],
    this.durationProvenance,
    this.sampledHexColors = const [],
  });

  final String rawText;
  final int? durationSeconds;
  final List<int> weightsMg;
  final int confidenceBasisPoints;
  final List<OcrMaterialDetection> materials;
  final String? durationProvenance;
  final List<String> sampledHexColors;

  bool get needsConfirmation =>
      durationSeconds == null ||
      weightsMg.isEmpty ||
      materials.any((material) => !material.hasResolvedColor) ||
      confidenceBasisPoints < 9000;
}

class OcrPostProcessor {
  const OcrPostProcessor();

  OcrEstimate parse(String text, {List<String> sampledHexColors = const []}) {
    final weights = <int>[];
    for (final match in RegExp(
      r'(\d+(?:[.,]\d+)?)\s*(?:g|gram|grams)\b',
      caseSensitive: false,
    ).allMatches(text)) {
      final grams = double.tryParse(match.group(1)!.replaceAll(',', '.'));
      if (grams != null && grams >= 0 && grams < 100000) {
        weights.add((grams * 1000).round());
      }
    }

    int? duration;
    String? durationProvenance;
    final human = RegExp(
      r'(?:(\d+)\s*h(?:ours?)?)?\s*(?:(\d+)\s*m(?:in(?:utes?)?)?)?\s*(?:(\d+)\s*s(?:ec(?:onds?)?)?)',
      caseSensitive: false,
    ).allMatches(text).where((match) => match.group(0)!.trim().isNotEmpty);
    for (final match in human) {
      if (match.group(1) != null ||
          match.group(2) != null ||
          match.group(3) != null) {
        duration =
            (int.tryParse(match.group(1) ?? '') ?? 0) * 3600 +
            (int.tryParse(match.group(2) ?? '') ?? 0) * 60 +
            (int.tryParse(match.group(3) ?? '') ?? 0);
        durationProvenance = 'human duration';
        if (duration > 0) break;
      }
    }
    if (duration == null) {
      duration = _clockSeconds(text);
      if (duration != null) durationProvenance = 'HH:MM:SS';
    }

    final materialTypes = RegExp(
      r'\b(PLA\+?|PETG|ABS|ASA|TPU|TPE|PA(?:6|12)?|NYLON|PC|PVA|HIPS)\b',
      caseSensitive: false,
    ).allMatches(text).map((match) => match.group(1)!.toUpperCase()).toList();
    final colorNames = RegExp(
      r'\b(black|white|red|green|blue|yellow|orange|purple|violet|pink|magenta|cyan|teal|brown|grey|gray|silver|gold|beige|natural|transparent|clear)\b',
      caseSensitive: false,
    ).allMatches(text).map((match) => match.group(1)!.toLowerCase()).toList();
    final textHexColors = RegExp(r'#[0-9a-fA-F]{6}\b')
        .allMatches(text)
        .map((match) => match.group(0)!.toUpperCase())
        .toList();
    final allHexColors = [...textHexColors, ...sampledHexColors];
    final materials = <OcrMaterialDetection>[
      for (var index = 0; index < weights.length; index++)
        OcrMaterialDetection(
          toolIndex: index,
          weightMg: weights[index],
          materialType: index < materialTypes.length
              ? materialTypes[index]
              : null,
          colorName: index < colorNames.length ? colorNames[index] : null,
          colorHex: index < allHexColors.length ? allHexColors[index] : null,
          confidenceBasisPoints:
              index < textHexColors.length || index < colorNames.length
              ? 9200
              : index < allHexColors.length
              ? 7000
              : 5500,
          provenance: index < textHexColors.length
              ? 'ocr hex text'
              : index < allHexColors.length
              ? 'sampled image swatch'
              : 'ocr weight only',
        ),
    ];

    final confidence = duration != null && weights.isNotEmpty
        ? 9200
        : duration != null || weights.isNotEmpty
        ? 6500
        : 2000;
    return OcrEstimate(
      rawText: text,
      durationSeconds: duration,
      weightsMg: weights,
      confidenceBasisPoints: confidence,
      materials: materials,
      durationProvenance: durationProvenance,
      sampledHexColors: List.unmodifiable(sampledHexColors),
    );
  }

  int? _clockSeconds(String text) {
    final match = RegExp(r'\b(\d{1,3}):(\d{2}):(\d{2})\b').firstMatch(text);
    if (match == null) return null;
    return int.parse(match.group(1)!) * 3600 +
        int.parse(match.group(2)!) * 60 +
        int.parse(match.group(3)!);
  }
}
