import 'dart:io';

import 'package:filarithm/core/viewer/mesh_importer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const importer = MeshImporter();

  test('imports and triangulates OBJ polygon geometry', () async {
    final directory = await Directory.systemTemp.createTemp('filarithm_mesh_');
    final file = File('${directory.path}${Platform.pathSeparator}quad.obj');
    await file.writeAsString('''
v 0 0 0
v 10 0 0
v 10 10 0
v 0 10 0
f 1 2 3 4
''');
    try {
      final mesh = await importer.importFile(file);
      expect(mesh.vertices, hasLength(4));
      expect(mesh.triangles, hasLength(2));
      expect(mesh.diagonal, closeTo(14.142, 0.01));
    } finally {
      await directory.delete(recursive: true);
    }
  });

  test('imports STEP control points with an explicit preview notice', () async {
    final directory = await Directory.systemTemp.createTemp('filarithm_step_');
    final file = File('${directory.path}${Platform.pathSeparator}part.step');
    await file.writeAsString("#1=CARTESIAN_POINT('',(1.0,2.0,3.0));");
    try {
      final mesh = await importer.importFile(file);
      expect(mesh.format, 'STEP');
      expect(mesh.vertices.single.z, 3);
      expect(mesh.notice, contains('control-point preview'));
    } finally {
      await directory.delete(recursive: true);
    }
  });
}
