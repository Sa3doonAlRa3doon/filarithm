import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import '../domain/print_project.dart';

class GcodeParser {
  const GcodeParser({
    this.edgeBytes = 256 * 1024,
    this.maxFallbackMatchedBytes = 2 * 1024 * 1024,
    this.filamentDiameterMillimeters = 1.75,
    this.defaultDensityGramsPerCubicCentimeter = 1.24,
  });

  final int edgeBytes;
  final int maxFallbackMatchedBytes;
  final double filamentDiameterMillimeters;
  final double defaultDensityGramsPerCubicCentimeter;

  Future<ParsedPrintProject> parseFile(File file) async {
    final length = await file.length();
    final handle = await file.open();
    try {
      final headLength = math.min(edgeBytes, length);
      final head = await handle.read(headLength);
      var tail = <int>[];
      if (length > headLength) {
        await handle.setPosition(math.max(headLength, length - edgeBytes));
        tail = await handle.read(math.min(edgeBytes, length - headLength));
      }
      final text = '${_decode(head)}\n${_decode(tail)}';
      final edgeResult = parseText(text, sourceName: _basename(file.path));
      if (edgeResult.hasUsableStatistics || length <= edgeBytes * 2) {
        return edgeResult;
      }
      final fallbackText = await _streamMetadata(file);
      final streamed = parseText(
        '$text\n$fallbackText',
        sourceName: _basename(file.path),
      );
      return ParsedPrintProject(
        sourceName: streamed.sourceName,
        slicer: streamed.slicer,
        slicerVersion: streamed.slicerVersion,
        plates: streamed.plates,
        confidenceBasisPoints: streamed.confidenceBasisPoints,
        warnings: [
          ...streamed.warnings,
          const ParseWarning(
            code: 'streaming_metadata_fallback',
            message:
                'Required metadata was found using a bounded streaming scan.',
            severity: ParseSeverity.info,
          ),
        ],
      );
    } finally {
      await handle.close();
    }
  }

  ParsedPrintProject parseBytes(
    Uint8List bytes, {
    required String sourceName,
  }) => parseText(_decode(bytes), sourceName: sourceName);

  ParsedPrintProject parseText(String text, {required String sourceName}) {
    final slicer = _detectSlicer(text);
    final warnings = <ParseWarning>[];
    final durationMatch = _parseDuration(text);
    final durationSeconds = durationMatch.seconds;
    final types = _listSetting(text, const [
      'filament_type',
      'filament_settings_id',
    ]);
    final colors = _listSetting(text, const [
      'filament_colour',
      'filament_color',
      'extruder_colour',
      'extruder_color',
    ]);
    final gramMatch = _parseGramValues(text);
    final gramValues = gramMatch.values;
    final explicitSplit = _parseExplicitConsumptionSplit(text);
    final materials = <MaterialConsumption>[];

    if (explicitSplit.model.isNotEmpty && explicitSplit.purge.isNotEmpty) {
      final count = math.max(
        explicitSplit.model.length,
        explicitSplit.purge.length,
      );
      for (var index = 0; index < count; index++) {
        final model = index < explicitSplit.model.length
            ? explicitSplit.model[index]
            : 0.0;
        final purge = index < explicitSplit.purge.length
            ? explicitSplit.purge[index]
            : 0.0;
        materials.add(
          MaterialConsumption(
            toolIndex: index,
            modelMassMg: (model * 1000).round(),
            purgeMassMg: (purge * 1000).round(),
            materialType: index < types.length ? types[index] : null,
            colorHex: index < colors.length
                ? _normalizeColor(colors[index])
                : null,
            confidenceBasisPoints: 9300,
            source: ValueSource.gcodeComment,
            provenanceKey:
                '${explicitSplit.modelKey}+${explicitSplit.purgeKey}',
          ),
        );
      }
    } else if (gramValues.isNotEmpty) {
      for (var index = 0; index < gramValues.length; index++) {
        materials.add(
          MaterialConsumption(
            toolIndex: index,
            reportedTotalMassMg: (gramValues[index] * 1000).round(),
            materialType: index < types.length ? types[index] : null,
            colorHex: index < colors.length
                ? _normalizeColor(colors[index])
                : null,
            confidenceBasisPoints: gramMatch.fallback ? 8500 : 9300,
            source: ValueSource.gcodeComment,
            provenanceKey: gramMatch.key,
          ),
        );
      }
    } else {
      final lengthMeters = _parseFilamentLengthMeters(text);
      if (lengthMeters != null) {
        final grams = _lengthMetersToGrams(lengthMeters);
        materials.add(
          MaterialConsumption(
            toolIndex: 0,
            reportedTotalMassMg: (grams * 1000).round(),
            materialType: types.isEmpty ? null : types.first,
            colorHex: colors.isEmpty ? null : _normalizeColor(colors.first),
            confidenceBasisPoints: 8500,
            source: ValueSource.gcodeComment,
            provenanceKey: 'filament_length_converted',
          ),
        );
        warnings.add(
          const ParseWarning(
            code: 'length_converted',
            message: 'Filament length was converted to weight using the configured diameter and density.',
            severity: ParseSeverity.info,
          ),
        );
      }
    }

    if (explicitSplit.model.isNotEmpty != explicitSplit.purge.isNotEmpty) {
      warnings.add(
        const ParseWarning(
          code: 'partial_consumption_split',
          message: 'Only one model/purge field was recognized; total consumption is retained without inventing the missing split.',
        ),
      );
    }
    if (durationMatch.fallback || gramMatch.fallback) {
      warnings.add(
        const ParseWarning(
          code: 'version_fallback_key',
          message: 'One or more values used a version-tolerant fallback key and require review.',
        ),
      );
    }

    if (durationSeconds == 0) {
      warnings.add(
        const ParseWarning(
          code: 'missing_time',
          message: 'No supported print-time field was found.',
        ),
      );
    }
    if (materials.isEmpty) {
      warnings.add(
        const ParseWarning(
          code: 'missing_material',
          message: 'No supported filament weight or length field was found.',
        ),
      );
    }
    if (slicer == SlicerKind.unknown) {
      warnings.add(
        const ParseWarning(
          code: 'unknown_slicer',
          message: 'The slicer could not be identified; generic metadata rules were used.',
        ),
      );
    }

    return ParsedPrintProject(
      sourceName: sourceName,
      slicer: slicer,
      slicerVersion: _slicerVersion(text),
      confidenceBasisPoints: durationSeconds > 0 && materials.isNotEmpty
          ? 9300
          : 6500,
      warnings: warnings,
      plates: [
        PlateEstimate(
          id: 'plate-1',
          name: 'Plate 1',
          durationSeconds: durationSeconds,
          durationProvenanceKey: durationMatch.key,
          durationConfidenceBasisPoints: durationMatch.fallback ? 8500 : 9300,
          materials: materials,
        ),
      ],
    );
  }

  SlicerKind _detectSlicer(String text) {
    final value = text.toLowerCase();
    if (value.contains('bambu studio')) return SlicerKind.bambuStudio;
    if (value.contains('orcaslicer') || value.contains('orca slicer')) {
      return SlicerKind.orcaSlicer;
    }
    if (value.contains('creality print') || value.contains('crealityprint')) {
      return SlicerKind.crealityPrint;
    }
    if (value.contains('prusaslicer') || value.contains('prusa slicer')) {
      return SlicerKind.prusaSlicer;
    }
    if (value.contains('cura') || value.contains(';time:')) {
      return SlicerKind.cura;
    }
    return SlicerKind.unknown;
  }

  String? _slicerVersion(String text) {
    final match = RegExp(
      r'(?:generated with|generated by|slicer_version\s*=)\s*([^\r\n;]+)',
      caseSensitive: false,
    ).firstMatch(text);
    return match?.group(1)?.trim();
  }

  ({int seconds, String? key, bool fallback}) _parseDuration(String text) {
    final secondsPatterns = <({RegExp pattern, String key, bool fallback})>[
      (
        pattern: RegExp(
          r'^;\s*TIME\s*:\s*(\d+)\s*$',
          caseSensitive: false,
          multiLine: true,
        ),
        key: 'TIME',
        fallback: false,
      ),
      (
        pattern: RegExp(
          r'(?:prediction|print_time|total_time)\s*=\s*(\d+)\s*$',
          caseSensitive: false,
          multiLine: true,
        ),
        key: 'prediction|print_time|total_time',
        fallback: true,
      ),
    ];
    for (final rule in secondsPatterns) {
      final match = rule.pattern.firstMatch(text);
      if (match != null) {
        return (
          seconds: int.tryParse(match.group(1)!) ?? 0,
          key: rule.key,
          fallback: rule.fallback,
        );
      }
    }

    final labelledRules = <({RegExp pattern, String key, bool fallback})>[
      (
        pattern: RegExp(
          r'total estimated time\s*(?:=|:)\s*([^\r\n;]+)',
          caseSensitive: false,
        ),
        key: 'total estimated time',
        fallback: false,
      ),
      (
        pattern: RegExp(
          r'estimated printing time(?: \([^)]*\))?\s*(?:=|:)\s*([^\r\n;]+)',
          caseSensitive: false,
        ),
        key: 'estimated printing time',
        fallback: true,
      ),
      (
        pattern: RegExp(
          r'print time\s*(?:=|:)\s*([^\r\n;]+)',
          caseSensitive: false,
        ),
        key: 'print time',
        fallback: true,
      ),
    ];
    for (final rule in labelledRules) {
      final match = rule.pattern.firstMatch(text);
      if (match != null) {
        return (
          seconds: _durationStringSeconds(match.group(1)!),
          key: rule.key,
          fallback: rule.fallback,
        );
      }
    }

    final clock = RegExp(r'\b(\d{1,3}):(\d{2}):(\d{2})\b').firstMatch(text);
    if (clock != null) {
      return (
        seconds:
            int.parse(clock.group(1)!) * 3600 +
            int.parse(clock.group(2)!) * 60 +
            int.parse(clock.group(3)!),
        key: 'HH:MM:SS',
        fallback: true,
      );
    }
    return (seconds: 0, key: null, fallback: false);
  }

  int _durationStringSeconds(String value) {
    final hours = RegExp(
      r'(\d+(?:\.\d+)?)\s*h',
      caseSensitive: false,
    ).firstMatch(value);
    final minutes = RegExp(
      r'(\d+(?:\.\d+)?)\s*m(?!s)',
      caseSensitive: false,
    ).firstMatch(value);
    final seconds = RegExp(
      r'(\d+(?:\.\d+)?)\s*s',
      caseSensitive: false,
    ).firstMatch(value);
    return ((double.tryParse(hours?.group(1) ?? '0') ?? 0) * 3600 +
            (double.tryParse(minutes?.group(1) ?? '0') ?? 0) * 60 +
            (double.tryParse(seconds?.group(1) ?? '0') ?? 0))
        .round();
  }

  ({List<double> values, String? key, bool fallback}) _parseGramValues(
    String text,
  ) {
    final patterns = <({RegExp pattern, String key, bool fallback})>[
      (
        pattern: RegExp(
          r'^;\s*filament used \[g\]\s*=\s*([^\r\n]+)',
          caseSensitive: false,
          multiLine: true,
        ),
        key: 'filament used [g]',
        fallback: false,
      ),
      (
        pattern: RegExp(
          r'^;\s*total filament (?:used|weight) \[g\]\s*=\s*([^\r\n]+)',
          caseSensitive: false,
          multiLine: true,
        ),
        key: 'total filament used|weight [g]',
        fallback: true,
      ),
      (
        pattern: RegExp(
          r'^;\s*filament_weight\s*=\s*([^\r\n]+)',
          caseSensitive: false,
          multiLine: true,
        ),
        key: 'filament_weight',
        fallback: true,
      ),
      (
        pattern: RegExp(
          r'^;\s*filament used\s*:\s*([\d.,; ]+)\s*g\s*$',
          caseSensitive: false,
          multiLine: true,
        ),
        key: 'Filament used: g',
        fallback: true,
      ),
    ];
    for (final rule in patterns) {
      final match = rule.pattern.firstMatch(text);
      if (match == null) continue;
      final values = RegExp(r'\d+(?:\.\d+)?')
          .allMatches(match.group(1)!)
          .map((match) => double.parse(match.group(0)!))
          .toList();
      if (values.isNotEmpty) {
        return (values: values, key: rule.key, fallback: rule.fallback);
      }
    }
    return (values: const [], key: null, fallback: false);
  }

  ({List<double> model, List<double> purge, String? modelKey, String? purgeKey})
  _parseExplicitConsumptionSplit(String text) {
    final model = _parseNamedGramList(text, const [
      'model filament',
      'model weight',
      'model filament weight',
    ]);
    final purge = _parseNamedGramList(text, const [
      'purge filament',
      'purge weight',
      'flushing weight',
      'flush weight',
      'waste filament',
    ]);
    return (
      model: model.values,
      purge: purge.values,
      modelKey: model.key,
      purgeKey: purge.key,
    );
  }

  ({List<double> values, String? key}) _parseNamedGramList(
    String text,
    List<String> keys,
  ) {
    for (final key in keys) {
      final match = RegExp(
        '^;?\\s*${RegExp.escape(key)}(?:\\s*\\[g\\])?\\s*(?:=|:)\\s*([^\\r\\n]+)',
        caseSensitive: false,
        multiLine: true,
      ).firstMatch(text);
      if (match == null) continue;
      final values = RegExp(r'\d+(?:\.\d+)?')
          .allMatches(match.group(1)!)
          .map((value) => double.parse(value.group(0)!))
          .toList();
      if (values.isNotEmpty) return (values: values, key: key);
    }
    return (values: const [], key: null);
  }

  double? _parseFilamentLengthMeters(String text) {
    final match = RegExp(
      r'^;\s*Filament used\s*:\s*(\d+(?:\.\d+)?)\s*(mm|m)\s*$',
      caseSensitive: false,
      multiLine: true,
    ).firstMatch(text);
    if (match == null) return null;
    final value = double.parse(match.group(1)!);
    return match.group(2)!.toLowerCase() == 'mm' ? value / 1000 : value;
  }

  double _lengthMetersToGrams(double lengthMeters) {
    final radius = filamentDiameterMillimeters / 2;
    final volumeCubicMillimeters =
        math.pi * radius * radius * lengthMeters * 1000;
    return volumeCubicMillimeters *
        defaultDensityGramsPerCubicCentimeter /
        1000;
  }

  List<String> _listSetting(String text, List<String> keys) {
    for (final key in keys) {
      final match = RegExp(
        '^;?\\s*${RegExp.escape(key)}\\s*=\\s*([^\\r\\n]+)',
        caseSensitive: false,
        multiLine: true,
      ).firstMatch(text);
      if (match == null) continue;
      return match
          .group(1)!
          .split(RegExp(r'\s*;\s*|\s*,\s*'))
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList();
    }
    return const [];
  }

  String? _normalizeColor(String value) {
    final match = RegExp(r'#?([0-9a-fA-F]{6})(?:[0-9a-fA-F]{2})?')
        .firstMatch(value);
    return match == null ? null : '#${match.group(1)!.toUpperCase()}';
  }

  Future<String> _streamMetadata(File file) async {
    final output = StringBuffer();
    const markers = <String>[
      'generated by',
      'generated with',
      'slicer_version',
      'filament',
      'print time',
      'estimated time',
      'prediction',
      'total_time',
      ';time:',
      'flush',
      'purge',
      'waste',
      'extruder_color',
      'extruder_colour',
    ];
    await for (final line
        in file
            .openRead()
            .transform(const Utf8Decoder(allowMalformed: true))
            .transform(const LineSplitter())) {
      final lower = line.toLowerCase();
      if (!markers.any(lower.contains)) continue;
      if (output.length + line.length + 1 > maxFallbackMatchedBytes) {
        break;
      }
      output.writeln(line);
    }
    return output.toString();
  }

  String _decode(List<int> bytes) => utf8.decode(bytes, allowMalformed: true);

  String _basename(String path) => path.split(RegExp(r'[/\\]')).last;
}
