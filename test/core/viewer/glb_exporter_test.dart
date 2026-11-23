import 'package:filarithm/core/viewer/glb_exporter.dart';
import 'package:filarithm/core/viewer/mesh_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  test('exports a valid GLB 2 header and aligned chunks', () {
    final bytes = const GlbExporter().export(
      MeshModel(
        name: 'triangle',
        format: 'TEST',
        vertices: [Vector3.zero(), Vector3(10, 0, 0), Vector3(0, 10, 0)],
        triangles: const [
          [0, 1, 2],
        ],
      ),
    );
    expect(bytes[0], 0x67);
    expect(bytes[1], 0x6C);
    expect(bytes[2], 0x54);
    expect(bytes[3], 0x46);
    expect(bytes.length % 4, 0);
  });
}
