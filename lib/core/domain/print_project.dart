import 'dart:convert';

enum SlicerKind {
  crealityPrint,
  orcaSlicer,
  bambuStudio,
  prusaSlicer,
  cura,
  unknown,
}

enum ParseSeverity { info, warning, error }

enum ValueSource { slicerMetadata, gcodeComment, ocr, manual }

class ParseWarning {
  const ParseWarning({
    required this.code,
    required this.message,
    this.severity = ParseSeverity.warning,
  });

  final String code;
  final String message;
  final ParseSeverity severity;

  Map<String, Object?> toJson() => {
    'code': code,
    'message': message,
    'severity': severity.name,
  };
}

class MaterialConsumption {
  const MaterialConsumption({
    required this.toolIndex,
    this.modelMassMg = 0,
    this.purgeMassMg = 0,
    this.reportedTotalMassMg,
    this.materialType,
    this.colorHex,
    this.colorName,
    this.materialProfileId,
    this.confidenceBasisPoints = 10000,
    this.source = ValueSource.slicerMetadata,
    this.provenanceKey,
  }) : assert(modelMassMg >= 0),
       assert(purgeMassMg >= 0),
       assert(reportedTotalMassMg == null || reportedTotalMassMg >= 0),
       assert(confidenceBasisPoints >= 0 && confidenceBasisPoints <= 10000);

  final int toolIndex;
  final int modelMassMg;
  final int purgeMassMg;
  final int? reportedTotalMassMg;
  final String? materialType;
  final String? colorHex;
  final String? colorName;
  final String? materialProfileId;
  final int confidenceBasisPoints;
  final ValueSource source;
  final String? provenanceKey;

  int get totalConsumedMassMg =>
      reportedTotalMassMg ?? modelMassMg + purgeMassMg;

  bool get needsConfirmation =>
      confidenceBasisPoints < 9000 || materialProfileId == null;

  MaterialConsumption copyWith({
    int? toolIndex,
    int? modelMassMg,
    int? purgeMassMg,
    int? reportedTotalMassMg,
    bool clearReportedTotal = false,
    String? materialType,
    String? colorHex,
    String? colorName,
    String? materialProfileId,
    int? confidenceBasisPoints,
    ValueSource? source,
    String? provenanceKey,
  }) {
    return MaterialConsumption(
      toolIndex: toolIndex ?? this.toolIndex,
      modelMassMg: modelMassMg ?? this.modelMassMg,
      purgeMassMg: purgeMassMg ?? this.purgeMassMg,
      reportedTotalMassMg: clearReportedTotal
          ? null
          : reportedTotalMassMg ?? this.reportedTotalMassMg,
      materialType: materialType ?? this.materialType,
      colorHex: colorHex ?? this.colorHex,
      colorName: colorName ?? this.colorName,
      materialProfileId: materialProfileId ?? this.materialProfileId,
      confidenceBasisPoints:
          confidenceBasisPoints ?? this.confidenceBasisPoints,
      source: source ?? this.source,
      provenanceKey: provenanceKey ?? this.provenanceKey,
    );
  }

  Map<String, Object?> toJson() => {
    'toolIndex': toolIndex,
    'modelMassMg': modelMassMg,
    'purgeMassMg': purgeMassMg,
    'reportedTotalMassMg': reportedTotalMassMg,
    'totalConsumedMassMg': totalConsumedMassMg,
    'materialType': materialType,
    'colorHex': colorHex,
    'colorName': colorName,
    'materialProfileId': materialProfileId,
    'confidenceBasisPoints': confidenceBasisPoints,
    'source': source.name,
    'provenanceKey': provenanceKey,
  };
}

class PlateEstimate {
  const PlateEstimate({
    required this.id,
    required this.name,
    required this.durationSeconds,
    required this.materials,
    this.selected = true,
    this.unitsPerRun = 1,
    this.plateRuns = 1,
    this.printerName,
    this.durationProvenanceKey,
    this.durationConfidenceBasisPoints = 10000,
  }) : assert(durationSeconds >= 0),
       assert(unitsPerRun > 0),
       assert(plateRuns >= 0),
       assert(
         durationConfidenceBasisPoints >= 0 &&
             durationConfidenceBasisPoints <= 10000,
       );

  final String id;
  final String name;
  final int durationSeconds;
  final List<MaterialConsumption> materials;
  final bool selected;
  final int unitsPerRun;
  final int plateRuns;
  final String? printerName;
  final String? durationProvenanceKey;
  final int durationConfidenceBasisPoints;

  int get finishedUnits => unitsPerRun * plateRuns;
  int get totalDurationSeconds => selected ? durationSeconds * plateRuns : 0;

  PlateEstimate copyWith({
    String? id,
    String? name,
    int? durationSeconds,
    List<MaterialConsumption>? materials,
    bool? selected,
    int? unitsPerRun,
    int? plateRuns,
    String? printerName,
    String? durationProvenanceKey,
    int? durationConfidenceBasisPoints,
  }) {
    return PlateEstimate(
      id: id ?? this.id,
      name: name ?? this.name,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      materials: materials ?? this.materials,
      selected: selected ?? this.selected,
      unitsPerRun: unitsPerRun ?? this.unitsPerRun,
      plateRuns: plateRuns ?? this.plateRuns,
      printerName: printerName ?? this.printerName,
      durationProvenanceKey:
          durationProvenanceKey ?? this.durationProvenanceKey,
      durationConfidenceBasisPoints:
          durationConfidenceBasisPoints ?? this.durationConfidenceBasisPoints,
    );
  }

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'durationSeconds': durationSeconds,
    'selected': selected,
    'unitsPerRun': unitsPerRun,
    'plateRuns': plateRuns,
    'finishedUnits': finishedUnits,
    'printerName': printerName,
    'durationProvenanceKey': durationProvenanceKey,
    'durationConfidenceBasisPoints': durationConfidenceBasisPoints,
    'materials': materials.map((material) => material.toJson()).toList(),
  };
}

class ParsedPrintProject {
  const ParsedPrintProject({
    required this.sourceName,
    required this.slicer,
    required this.plates,
    this.warnings = const [],
    this.confidenceBasisPoints = 10000,
    this.slicerVersion,
  });

  final String sourceName;
  final SlicerKind slicer;
  final String? slicerVersion;
  final List<PlateEstimate> plates;
  final List<ParseWarning> warnings;
  final int confidenceBasisPoints;

  bool get hasUsableStatistics => plates.any(
    (plate) =>
        plate.durationSeconds > 0 &&
        plate.materials.any((material) => material.totalConsumedMassMg > 0),
  );

  bool get needsConfirmation =>
      confidenceBasisPoints < 9000 ||
      warnings.any((warning) => warning.severity != ParseSeverity.info) ||
      plates.any(
        (plate) =>
            plate.materials.any((material) => material.needsConfirmation),
      );

  Map<String, Object?> toJson() => {
    'sourceName': sourceName,
    'slicer': slicer.name,
    'slicerVersion': slicerVersion,
    'confidenceBasisPoints': confidenceBasisPoints,
    'hasUsableStatistics': hasUsableStatistics,
    'warnings': warnings.map((warning) => warning.toJson()).toList(),
    'plates': plates.map((plate) => plate.toJson()).toList(),
  };

  String toPrettyJson() => const JsonEncoder.withIndent('  ').convert(toJson());
}
