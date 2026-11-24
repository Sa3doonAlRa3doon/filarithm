import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../domain/print_project.dart';
import 'gcode_parser.dart';

class ThreeMfParser {
  const ThreeMfParser({
    this.maxArchiveBytes = 256 * 1024 * 1024,
    this.maxEntryBytes = 24 * 1024 * 1024,
    this.maxInspectedBytes = 72 * 1024 * 1024,
    this.maxTotalExpandedBytes = 512 * 1024 * 1024,
    this.maxExpansionRatio = 200,
    this.gcodeParser = const GcodeParser(),
  });

  final int maxArchiveBytes;
  final int maxEntryBytes;
  final int maxInspectedBytes;
  final int maxTotalExpandedBytes;
  final int maxExpansionRatio;
  final GcodeParser gcodeParser;

  static final RegExp _allowedEntry = RegExp(
    r'^(Metadata/(?:plate_\d+\.gcode|slice_info\.config|project_settings\.config|Slic3r_PE\.config)|3D/3dmodel\.model)$',
    caseSensitive: false,
  );

  Future<ParsedPrintProject> parseFile(File file) async {
    final length = await file.length();
    if (length > maxArchiveBytes) {
      throw const FormatException(
        'The 3MF archive is larger than the safe import limit.',
      );
    }
    return parseBytes(
      await file.readAsBytes(),
      sourceName: _basename(file.path),
    );
  }

  ParsedPrintProject parseBytes(Uint8List bytes, {required String sourceName}) {
    if (bytes.length > maxArchiveBytes) {
      throw const FormatException(
        'The 3MF archive is larger than the safe import limit.',
      );
    }
    late final Archive archive;
    try {
      archive = ZipDecoder().decodeBytes(bytes, verify: true);
    } catch (_) {
      throw const FormatException('The 3MF archive is corrupt or unsupported.');
    }

    var inspectedBytes = 0;
    var totalExpandedBytes = 0;
    final relevant = <String, String>{};
    for (final entry in archive.files) {
      final normalized = entry.name.replaceAll('\\', '/');
      if (!entry.isFile) continue;
      totalExpandedBytes += entry.size;
      if (totalExpandedBytes > maxTotalExpandedBytes) {
        throw const FormatException(
          'The 3MF expanded content exceeds the safe archive limit.',
        );
      }
      final compressedBytes = entry.rawContent?.length ?? 0;
      if (compressedBytes > 0 &&
          entry.size > compressedBytes * maxExpansionRatio) {
        throw FormatException(
          'The 3MF entry $normalized has an unsafe compression ratio.',
        );
      }
      if (RegExp(
        r'\.(?:zip|3mf|7z|rar|tar|gz|bz2|xz)$',
        caseSensitive: false,
      ).hasMatch(normalized)) {
        throw FormatException(
          'Nested archive entry $normalized is not allowed in a 3MF import.',
        );
      }
      if (!_allowedEntry.hasMatch(normalized)) continue;
      if (entry.size > maxEntryBytes) {
        throw FormatException(
          'The 3MF entry $normalized is larger than the safe limit.',
        );
      }
      inspectedBytes += entry.size;
      if (inspectedBytes > maxInspectedBytes) {
        throw const FormatException(
          'The 3MF metadata exceeds the safe inspection limit.',
        );
      }
      final data = entry.readBytes();
      if (data != null) {
        relevant[normalized] = utf8.decode(data, allowMalformed: true);
      }
    }

    final plates = <PlateEstimate>[];
    final plateEntries =
        relevant.entries
            .where(
              (entry) => RegExp(
                r'^Metadata/plate_\d+\.gcode$',
                caseSensitive: false,
              ).hasMatch(entry.key),
            )
            .toList()
          ..sort((a, b) => a.key.compareTo(b.key));
    SlicerKind slicer = SlicerKind.unknown;
    String? version;
    for (var index = 0; index < plateEntries.length; index++) {
      final entry = plateEntries[index];
      final parsed = gcodeParser.parseText(entry.value, sourceName: entry.key);
      if (parsed.slicer != SlicerKind.unknown) {
        slicer = parsed.slicer;
      }
      version ??= parsed.slicerVersion;
      if (parsed.plates.isNotEmpty) {
        final plate = parsed.plates.first;
        plates.add(
          plate.copyWith(id: 'plate-${index + 1}', name: 'Plate ${index + 1}'),
        );
      }
    }

    final metadataText = [
      relevant['Metadata/slice_info.config'],
      relevant['Metadata/project_settings.config'],
      relevant['Metadata/Slic3r_PE.config'],
    ].whereType<String>().join('\n');
    slicer = slicer == SlicerKind.unknown
        ? _detectMetadataSlicer(metadataText)
        : slicer;
    version ??= _detectMetadataVersion(metadataText, slicer);

    if (plates.isEmpty) {
      final fallback = _parseSliceInfo(metadataText);
      if (fallback != null) plates.add(fallback);
    }

    final warnings = <ParseWarning>[];
    if (plates.isEmpty || !plates.any((plate) => plate.durationSeconds > 0)) {
      warnings.add(
        const ParseWarning(
          code: 'unsliced_3mf',
          message: 'This 3MF does not contain usable sliced print statistics.',
          severity: ParseSeverity.error,
        ),
      );
    }
    if (slicer == SlicerKind.unknown) {
      warnings.add(
        const ParseWarning(
          code: 'unknown_3mf_slicer',
          message: 'The 3MF slicer could not be identified.',
        ),
      );
    }

    return ParsedPrintProject(
      sourceName: sourceName,
      slicer: slicer,
      slicerVersion: version,
      plates: plates,
      warnings: warnings,
      confidenceBasisPoints: plates.isEmpty ? 3000 : 9200,
    );
  }

  PlateEstimate? _parseSliceInfo(String text) {
    if (text.isEmpty) return null;
    final prediction = _attributeNumber(text, const [
      'prediction',
      'print_time',
      'time',
    ]);
    final weights = <double>[];
    for (final match in RegExp(
      r'(?:used_g|weight|filament_weight)\s*=\s*["\x27]([\d.]+)',
      caseSensitive: false,
    ).allMatches(text)) {
      final value = double.tryParse(match.group(1)!);
      if (value != null && value > 0) weights.add(value);
    }
    if ((prediction ?? 0) <= 0 && weights.isEmpty) return null;
    final colors = RegExp(r'#[0-9a-fA-F]{6}')
        .allMatches(text)
        .map((m) => m.group(0)!.toUpperCase())
        .toList();
    return PlateEstimate(
      id: 'plate-1',
      name: 'Plate 1',
      durationSeconds: (prediction ?? 0).round(),
      materials: [
        for (var index = 0; index < weights.length; index++)
          MaterialConsumption(
            toolIndex: index,
            reportedTotalMassMg: (weights[index] * 1000).round(),
            colorHex: index < colors.length ? colors[index] : null,
            confidenceBasisPoints: 8200,
            source: ValueSource.slicerMetadata,
            provenanceKey: 'slice_info.config',
          ),
      ],
    );
  }

  double? _attributeNumber(String text, List<String> names) {
    for (final name in names) {
      final patterns = [
        RegExp(
          '${RegExp.escape(name)}\\s*=\\s*["\\x27]([\\d.]+)',
          caseSensitive: false,
        ),
        RegExp(
          'key\\s*=\\s*["\\x27]${RegExp.escape(name)}["\\x27][^>]*value\\s*=\\s*["\\x27]([\\d.]+)',
          caseSensitive: false,
        ),
      ];
      for (final pattern in patterns) {
        final match = pattern.firstMatch(text);
        if (match != null) return double.tryParse(match.group(1)!);
      }
    }
    return null;
  }

  SlicerKind _detectMetadataSlicer(String text) {
    final lower = text.toLowerCase();
    // Orca project settings commonly name a Bambu printer and include BBL
    // compatibility metadata. Prefer the explicit Orca generator marker so a
    // genuine Orca project is not mislabeled as Bambu Studio.
    if (lower.contains('orcaslicer') || lower.contains('orca_slicer')) {
      return SlicerKind.orcaSlicer;
    }
    if (lower.contains('bambu')) return SlicerKind.bambuStudio;
    if (lower.contains('creality')) return SlicerKind.crealityPrint;
    if (lower.contains('prusa') || lower.contains('slic3r')) {
      return SlicerKind.prusaSlicer;
    }
    if (lower.contains('cura')) return SlicerKind.cura;
    return SlicerKind.unknown;
  }

  String? _detectMetadataVersion(String text, SlicerKind slicer) {
    final keys = switch (slicer) {
      SlicerKind.orcaSlicer => const ['OrcaSlicer-Version'],
      SlicerKind.bambuStudio => const [
        'BambuStudio-Version',
        'X-BBL-Client-Version',
      ],
      SlicerKind.crealityPrint => const [
        'CrealityPrint-Version',
        'Creality-Version',
      ],
      SlicerKind.prusaSlicer => const [
        'PrusaSlicer-Version',
        'Slic3rPE-Version',
      ],
      SlicerKind.cura => const ['Cura-Version'],
      SlicerKind.unknown => const <String>[],
    };
    for (final key in keys) {
      final match = RegExp(
        'key\\s*=\\s*["\\x27]${RegExp.escape(key)}["\\x27][^>]*'
        'value\\s*=\\s*["\\x27]([^"\\x27]+)',
        caseSensitive: false,
      ).firstMatch(text);
      if (match != null) return match.group(1)?.trim();
    }
    return null;
  }

  String _basename(String path) => path.split(RegExp(r'[/\\]')).last;
}
