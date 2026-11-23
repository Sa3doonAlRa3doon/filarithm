import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:xml/xml.dart';

import 'mesh_model.dart';

class MeshImporter {
  const MeshImporter();

  Future<MeshModel> importFile(File file) async {
    final name = file.path.split(RegExp(r'[/\\]')).last;
    final extension = name.split('.').last.toLowerCase();
    final bytes = await file.readAsBytes();
    return switch (extension) {
      'obj' => _obj(name, utf8.decode(bytes, allowMalformed: true)),
      'stl' => _stl(name, bytes),
      '3mf' => _threeMf(name, bytes),
      'step' || 'stp' => _step(name, utf8.decode(bytes, allowMalformed: true)),
      'gltf' => _gltf(
        name,
        jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>,
        null,
      ),
      'glb' => _glb(name, bytes),
      _ => throw const FormatException(
        'Supported model formats: STL, OBJ, 3MF, GLTF, GLB, STEP/STP.',
      ),
    };
  }

  MeshModel _obj(String name, String text) {
    final vertices = <Vector3>[];
    final triangles = <List<int>>[];
    for (final raw in const LineSplitter().convert(text)) {
      final line = raw.trim();
      if (line.startsWith('v ')) {
        final values = line.substring(2).trim().split(RegExp(r'\s+'));
        if (values.length >= 3) {
          vertices.add(
            Vector3(
              double.tryParse(values[0]) ?? 0,
              double.tryParse(values[1]) ?? 0,
              double.tryParse(values[2]) ?? 0,
            ),
          );
        }
      } else if (line.startsWith('f ')) {
        final indices = line
            .substring(2)
            .trim()
            .split(RegExp(r'\s+'))
            .map((value) => int.tryParse(value.split('/').first))
            .whereType<int>()
            .map((value) => value < 0 ? vertices.length + value : value - 1)
            .toList();
        for (var index = 1; index + 1 < indices.length; index++) {
          triangles.add([indices[0], indices[index], indices[index + 1]]);
        }
      }
    }
    return _validated(name, 'OBJ', vertices, triangles);
  }

  MeshModel _stl(String name, Uint8List bytes) {
    if (bytes.length >= 84) {
      final view = ByteData.sublistView(bytes);
      final count = view.getUint32(80, Endian.little);
      if (84 + count * 50 <= bytes.length) {
        final vertices = <Vector3>[];
        final triangles = <List<int>>[];
        var offset = 84;
        for (var face = 0; face < count; face++) {
          offset += 12;
          final start = vertices.length;
          for (var corner = 0; corner < 3; corner++) {
            vertices.add(
              Vector3(
                view.getFloat32(offset, Endian.little),
                view.getFloat32(offset + 4, Endian.little),
                view.getFloat32(offset + 8, Endian.little),
              ),
            );
            offset += 12;
          }
          triangles.add([start, start + 1, start + 2]);
          offset += 2;
        }
        return _validated(name, 'STL', vertices, triangles);
      }
    }
    final text = utf8.decode(bytes, allowMalformed: true);
    final vertices =
        RegExp(
              r'vertex\s+([-+\deE.]+)\s+([-+\deE.]+)\s+([-+\deE.]+)',
              caseSensitive: false,
            )
            .allMatches(text)
            .map(
              (match) => Vector3(
                double.parse(match.group(1)!),
                double.parse(match.group(2)!),
                double.parse(match.group(3)!),
              ),
            )
            .toList();
    final triangles = <List<int>>[
      for (var index = 0; index + 2 < vertices.length; index += 3)
        [index, index + 1, index + 2],
    ];
    return _validated(name, 'STL', vertices, triangles);
  }

  MeshModel _threeMf(String name, Uint8List bytes) {
    final archive = ZipDecoder().decodeBytes(bytes, verify: true);
    final entry = archive.files.cast<ArchiveFile?>().firstWhere(
      (entry) =>
          entry!.name.replaceAll('\\', '/').toLowerCase() == '3d/3dmodel.model',
      orElse: () => null,
    );
    if (entry == null || entry.size > 64 * 1024 * 1024) {
      throw const FormatException('The 3MF has no safe 3D model entry.');
    }
    final document = XmlDocument.parse(
      utf8.decode(entry.content, allowMalformed: true),
    );
    final vertices = document
        .findAllElements('vertex')
        .map(
          (element) => Vector3(
            double.tryParse(element.getAttribute('x') ?? '') ?? 0,
            double.tryParse(element.getAttribute('y') ?? '') ?? 0,
            double.tryParse(element.getAttribute('z') ?? '') ?? 0,
          ),
        )
        .toList();
    final triangles = document
        .findAllElements('triangle')
        .map(
          (element) => [
            int.tryParse(element.getAttribute('v1') ?? '') ?? 0,
            int.tryParse(element.getAttribute('v2') ?? '') ?? 0,
            int.tryParse(element.getAttribute('v3') ?? '') ?? 0,
          ],
        )
        .toList();
    return _validated(name, '3MF', vertices, triangles);
  }

  MeshModel _step(String name, String text) {
    final vertices = <Vector3>[];
    for (final match in RegExp(
      r'CARTESIAN_POINT\s*\([^,]*,\s*\(\s*([-+\deE.]+)\s*,\s*([-+\deE.]+)\s*,\s*([-+\deE.]+)\s*\)\s*\)',
      caseSensitive: false,
    ).allMatches(text)) {
      vertices.add(
        Vector3(
          double.parse(match.group(1)!),
          double.parse(match.group(2)!),
          double.parse(match.group(3)!),
        ),
      );
    }
    if (vertices.isEmpty) {
      throw const FormatException('No STEP cartesian geometry was found.');
    }
    return MeshModel(
      name: name,
      format: 'STEP',
      vertices: vertices,
      triangles: const [],
      notice: 'STEP is shown as a control-point preview; exact B-Rep tessellation needs a CAD kernel.',
    );
  }

  MeshModel _glb(String name, Uint8List bytes) {
    if (bytes.length < 20 || ascii.decode(bytes.sublist(0, 4)) != 'glTF') {
      throw const FormatException('Invalid GLB header.');
    }
    final view = ByteData.sublistView(bytes);
    var offset = 12;
    Map<String, dynamic>? json;
    Uint8List? binary;
    while (offset + 8 <= bytes.length) {
      final length = view.getUint32(offset, Endian.little);
      final type = view.getUint32(offset + 4, Endian.little);
      offset += 8;
      if (offset + length > bytes.length) break;
      final chunk = bytes.sublist(offset, offset + length);
      if (type == 0x4E4F534A) {
        json =
            jsonDecode(utf8.decode(chunk).trimRight()) as Map<String, dynamic>;
      } else if (type == 0x004E4942) {
        binary = Uint8List.fromList(chunk);
      }
      offset += length;
    }
    if (json == null) {
      throw const FormatException('GLB JSON scene data is missing.');
    }
    return _gltf(name, json, binary);
  }

  MeshModel _gltf(
    String name,
    Map<String, dynamic> json,
    Uint8List? glbBinary,
  ) {
    final buffers = <Uint8List>[];
    for (final raw in (json['buffers'] as List<dynamic>? ?? const [])) {
      final buffer = raw as Map<String, dynamic>;
      final uri = buffer['uri'] as String?;
      if (uri?.startsWith('data:') == true) {
        buffers.add(base64Decode(uri!.split(',').last));
      } else if (glbBinary != null && buffers.isEmpty) {
        buffers.add(glbBinary);
      }
    }
    if (buffers.isEmpty && glbBinary != null) buffers.add(glbBinary);
    final views = (json['bufferViews'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    final accessors = (json['accessors'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    final vertices = <Vector3>[];
    final triangles = <List<int>>[];
    final meshes = (json['meshes'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    for (final mesh in meshes) {
      for (final rawPrimitive
          in (mesh['primitives'] as List<dynamic>? ?? const [])) {
        final primitive = rawPrimitive as Map<String, dynamic>;
        final attributes = primitive['attributes'] as Map<String, dynamic>?;
        final positionIndex = attributes?['POSITION'] as int?;
        if (positionIndex == null || positionIndex >= accessors.length) {
          continue;
        }
        final base = vertices.length;
        final positions = _readAccessor(
          accessors[positionIndex],
          views,
          buffers,
        );
        for (var i = 0; i + 2 < positions.length; i += 3) {
          vertices.add(
            Vector3(positions[i], positions[i + 1], positions[i + 2]),
          );
        }
        final indexAccessor = primitive['indices'] as int?;
        if (indexAccessor != null && indexAccessor < accessors.length) {
          final values = _readAccessor(
            accessors[indexAccessor],
            views,
            buffers,
          ).map((value) => value.toInt()).toList();
          for (var i = 0; i + 2 < values.length; i += 3) {
            triangles.add([
              base + values[i],
              base + values[i + 1],
              base + values[i + 2],
            ]);
          }
        } else {
          for (var i = base; i + 2 < vertices.length; i += 3) {
            triangles.add([i, i + 1, i + 2]);
          }
        }
      }
    }
    return _validated(
      name,
      glbBinary == null ? 'GLTF' : 'GLB',
      vertices,
      triangles,
    );
  }

  List<double> _readAccessor(
    Map<String, dynamic> accessor,
    List<Map<String, dynamic>> views,
    List<Uint8List> buffers,
  ) {
    final viewIndex = accessor['bufferView'] as int?;
    if (viewIndex == null || viewIndex >= views.length) return const [];
    final view = views[viewIndex];
    final bufferIndex = view['buffer'] as int? ?? 0;
    if (bufferIndex >= buffers.length) return const [];
    final componentType = accessor['componentType'] as int? ?? 5126;
    final count = accessor['count'] as int? ?? 0;
    final components = switch (accessor['type']) {
      'SCALAR' => 1,
      'VEC2' => 2,
      'VEC3' => 3,
      'VEC4' => 4,
      _ => 1,
    };
    final componentBytes = switch (componentType) {
      5120 || 5121 => 1,
      5122 || 5123 => 2,
      _ => 4,
    };
    final stride = view['byteStride'] as int? ?? componentBytes * components;
    final start =
        (view['byteOffset'] as int? ?? 0) +
        (accessor['byteOffset'] as int? ?? 0);
    final data = ByteData.sublistView(buffers[bufferIndex]);
    final result = <double>[];
    for (var item = 0; item < count; item++) {
      for (var component = 0; component < components; component++) {
        final offset = start + item * stride + component * componentBytes;
        if (offset + componentBytes > data.lengthInBytes) return result;
        result.add(switch (componentType) {
          5120 => data.getInt8(offset).toDouble(),
          5121 => data.getUint8(offset).toDouble(),
          5122 => data.getInt16(offset, Endian.little).toDouble(),
          5123 => data.getUint16(offset, Endian.little).toDouble(),
          5125 => data.getUint32(offset, Endian.little).toDouble(),
          _ => data.getFloat32(offset, Endian.little),
        });
      }
    }
    return result;
  }

  MeshModel _validated(
    String name,
    String format,
    List<Vector3> vertices,
    List<List<int>> triangles,
  ) {
    if (vertices.isEmpty) {
      throw FormatException('$format contains no readable mesh vertices.');
    }
    final validFaces = triangles
        .where(
          (face) =>
              face.length == 3 &&
              face.every((index) => index >= 0 && index < vertices.length),
        )
        .toList();
    return MeshModel(
      name: name,
      format: format,
      vertices: vertices,
      triangles: validFaces,
    );
  }
}
