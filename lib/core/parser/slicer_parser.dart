import 'dart:io';

import '../domain/print_project.dart';
import 'gcode_parser.dart';
import 'three_mf_parser.dart';

class SlicerParser {
  const SlicerParser({
    this.gcode = const GcodeParser(),
    this.threeMf = const ThreeMfParser(),
  });

  final GcodeParser gcode;
  final ThreeMfParser threeMf;

  Future<ParsedPrintProject> parseFile(File file) {
    final name = file.path.toLowerCase();
    if (name.endsWith('.gcode.3mf') || name.endsWith('.3mf')) {
      return threeMf.parseFile(file);
    }
    if (name.endsWith('.gcode')) return gcode.parseFile(file);
    throw const FormatException('Choose a .gcode, .3mf, or .gcode.3mf file.');
  }
}
