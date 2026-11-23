import 'package:vector_math/vector_math_64.dart';

class MeshModel {
  const MeshModel({
    required this.name,
    required this.format,
    required this.vertices,
    required this.triangles,
    this.notice,
  });

  final String name;
  final String format;
  final List<Vector3> vertices;
  final List<List<int>> triangles;
  final String? notice;

  Vector3 get center {
    if (vertices.isEmpty) return Vector3.zero();
    final minimum = Vector3.copy(vertices.first);
    final maximum = Vector3.copy(vertices.first);
    for (final vertex in vertices.skip(1)) {
      minimum.x = minimum.x < vertex.x ? minimum.x : vertex.x;
      minimum.y = minimum.y < vertex.y ? minimum.y : vertex.y;
      minimum.z = minimum.z < vertex.z ? minimum.z : vertex.z;
      maximum.x = maximum.x > vertex.x ? maximum.x : vertex.x;
      maximum.y = maximum.y > vertex.y ? maximum.y : vertex.y;
      maximum.z = maximum.z > vertex.z ? maximum.z : vertex.z;
    }
    return (minimum + maximum)..scale(0.5);
  }

  double get diagonal {
    if (vertices.isEmpty) return 1;
    final middle = center;
    var maximum = 0.0;
    for (final vertex in vertices) {
      final distance = vertex.distanceTo(middle);
      if (distance > maximum) maximum = distance;
    }
    return maximum == 0 ? 1 : maximum * 2;
  }

  Vector3 get dimensionsMillimeters {
    if (vertices.isEmpty) return Vector3.zero();
    final minimum = Vector3.copy(vertices.first);
    final maximum = Vector3.copy(vertices.first);
    for (final vertex in vertices.skip(1)) {
      minimum.x = mathMin(minimum.x, vertex.x);
      minimum.y = mathMin(minimum.y, vertex.y);
      minimum.z = mathMin(minimum.z, vertex.z);
      maximum.x = mathMax(maximum.x, vertex.x);
      maximum.y = mathMax(maximum.y, vertex.y);
      maximum.z = mathMax(maximum.z, vertex.z);
    }
    return maximum - minimum;
  }

  double mathMin(double left, double right) => left < right ? left : right;
  double mathMax(double left, double right) => left > right ? left : right;
}

class ObjectTransform {
  const ObjectTransform({
    this.positionX = 0,
    this.positionY = 0,
    this.positionZ = 0,
    this.rotationX = 0,
    this.rotationY = 0,
    this.rotationZ = 0,
    this.scaleX = 1,
    this.scaleY = 1,
    this.scaleZ = 1,
  });

  final double positionX;
  final double positionY;
  final double positionZ;
  final double rotationX;
  final double rotationY;
  final double rotationZ;
  final double scaleX;
  final double scaleY;
  final double scaleZ;

  ObjectTransform copyWith({
    double? positionX,
    double? positionY,
    double? positionZ,
    double? rotationX,
    double? rotationY,
    double? rotationZ,
    double? scaleX,
    double? scaleY,
    double? scaleZ,
  }) => ObjectTransform(
    positionX: positionX ?? this.positionX,
    positionY: positionY ?? this.positionY,
    positionZ: positionZ ?? this.positionZ,
    rotationX: rotationX ?? this.rotationX,
    rotationY: rotationY ?? this.rotationY,
    rotationZ: rotationZ ?? this.rotationZ,
    scaleX: scaleX ?? this.scaleX,
    scaleY: scaleY ?? this.scaleY,
    scaleZ: scaleZ ?? this.scaleZ,
  );

  Map<String, Object> toJson() => {
    'position': [positionX, positionY, positionZ],
    'rotationDegrees': [rotationX, rotationY, rotationZ],
    'scale': [scaleX, scaleY, scaleZ],
  };

  factory ObjectTransform.fromJson(Map<String, dynamic> json) {
    final position = (json['position'] as List<dynamic>? ?? const [0, 0, 0]);
    final rotation =
        (json['rotationDegrees'] as List<dynamic>? ?? const [0, 0, 0]);
    final scale = (json['scale'] as List<dynamic>? ?? const [1, 1, 1]);
    double value(List<dynamic> values, int index, double fallback) =>
        index < values.length && values[index] is num
        ? (values[index] as num).toDouble()
        : fallback;
    return ObjectTransform(
      positionX: value(position, 0, 0),
      positionY: value(position, 1, 0),
      positionZ: value(position, 2, 0),
      rotationX: value(rotation, 0, 0),
      rotationY: value(rotation, 1, 0),
      rotationZ: value(rotation, 2, 0),
      scaleX: value(scale, 0, 1),
      scaleY: value(scale, 1, 1),
      scaleZ: value(scale, 2, 1),
    );
  }
}
