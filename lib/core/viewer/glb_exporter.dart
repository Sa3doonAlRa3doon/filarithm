import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:vector_math/vector_math_64.dart';

import 'mesh_model.dart';

class GlbExporter {
  const GlbExporter();

  Uint8List export(MeshModel mesh, {ObjectTransform? transform}) {
    if (mesh.vertices.isEmpty) {
      throw const FormatException('The model has no vertices to export.');
    }
    final matrix = Matrix4.identity();
    if (transform != null) {
      matrix
        ..rotateX(transform.rotationX * math.pi / 180)
        ..rotateY(transform.rotationY * math.pi / 180)
        ..rotateZ(transform.rotationZ * math.pi / 180)
        ..scaleByVector3(
          Vector3(transform.scaleX, transform.scaleY, transform.scaleZ),
        );
    }
    final vertices = [
      for (final vertex in mesh.vertices)
        matrix.transform3(Vector3.copy(vertex)),
    ];
    final indices = <int>[
      for (final triangle in mesh.triangles)
        if (triangle.length >= 3) ...triangle.take(3),
    ];
    final positionBytes = vertices.length * 12;
    final indexOffset = _align4(positionBytes);
    final indexBytes = indices.length * 4;
    final binaryLength = _align4(indexOffset + indexBytes);
    final binary = ByteData(binaryLength);
    for (var index = 0; index < vertices.length; index++) {
      final offset = index * 12;
      binary
        ..setFloat32(offset, vertices[index].x, Endian.little)
        ..setFloat32(offset + 4, vertices[index].y, Endian.little)
        ..setFloat32(offset + 8, vertices[index].z, Endian.little);
    }
    for (var index = 0; index < indices.length; index++) {
      binary.setUint32(indexOffset + index * 4, indices[index], Endian.little);
    }
    final minimum = Vector3.copy(vertices.first);
    final maximum = Vector3.copy(vertices.first);
    for (final vertex in vertices.skip(1)) {
      minimum
        ..x = math.min(minimum.x, vertex.x)
        ..y = math.min(minimum.y, vertex.y)
        ..z = math.min(minimum.z, vertex.z);
      maximum
        ..x = math.max(maximum.x, vertex.x)
        ..y = math.max(maximum.y, vertex.y)
        ..z = math.max(maximum.z, vertex.z);
    }
    final primitive = <String, Object>{
      'attributes': {'POSITION': 0},
      'mode': indices.isEmpty ? 0 : 4,
      if (indices.isNotEmpty) 'indices': 1,
    };
    final json = <String, Object>{
      'asset': {'version': '2.0', 'generator': 'Filarithm by AVEONEX'},
      'scene': 0,
      'scenes': [
        {
          'nodes': [0],
        },
      ],
      'nodes': [
        {'mesh': 0, 'name': mesh.name},
      ],
      'meshes': [
        {
          'name': mesh.name,
          'primitives': [primitive],
        },
      ],
      'buffers': [
        {'byteLength': binaryLength},
      ],
      'bufferViews': [
        {'buffer': 0, 'byteOffset': 0, 'byteLength': positionBytes},
        if (indices.isNotEmpty)
          {
            'buffer': 0,
            'byteOffset': indexOffset,
            'byteLength': indexBytes,
            'target': 34963,
          },
      ],
      'accessors': [
        {
          'bufferView': 0,
          'componentType': 5126,
          'count': vertices.length,
          'type': 'VEC3',
          'min': [minimum.x, minimum.y, minimum.z],
          'max': [maximum.x, maximum.y, maximum.z],
        },
        if (indices.isNotEmpty)
          {
            'bufferView': 1,
            'componentType': 5125,
            'count': indices.length,
            'type': 'SCALAR',
          },
      ],
    };
    final jsonBytes = utf8.encode(jsonEncode(json));
    final jsonLength = _align4(jsonBytes.length);
    final totalLength = 12 + 8 + jsonLength + 8 + binaryLength;
    final output = ByteData(totalLength);
    output
      ..setUint32(0, 0x46546C67, Endian.little)
      ..setUint32(4, 2, Endian.little)
      ..setUint32(8, totalLength, Endian.little)
      ..setUint32(12, jsonLength, Endian.little)
      ..setUint32(16, 0x4E4F534A, Endian.little);
    final result = output.buffer.asUint8List();
    result.fillRange(20, 20 + jsonLength, 0x20);
    result.setRange(20, 20 + jsonBytes.length, jsonBytes);
    final binaryHeader = 20 + jsonLength;
    output
      ..setUint32(binaryHeader, binaryLength, Endian.little)
      ..setUint32(binaryHeader + 4, 0x004E4942, Endian.little);
    result.setRange(
      binaryHeader + 8,
      binaryHeader + 8 + binaryLength,
      binary.buffer.asUint8List(),
    );
    return result;
  }

  int _align4(int value) => (value + 3) & ~3;
}
