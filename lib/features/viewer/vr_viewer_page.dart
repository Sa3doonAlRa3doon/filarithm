import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

import '../../core/viewer/mesh_model.dart';
import '../../core/viewer/vr_controller_service.dart';

class VrViewerPage extends StatefulWidget {
  const VrViewerPage({required this.mesh, required this.transform, super.key});

  final MeshModel mesh;
  final ObjectTransform transform;

  @override
  State<VrViewerPage> createState() => _VrViewerPageState();
}

class _VrViewerPageState extends State<VrViewerPage> {
  final _focusNode = FocusNode();
  StreamSubscription<GyroscopeEvent>? _gyroscope;
  StreamSubscription<VrControllerEvent>? _controller;
  DateTime? _lastEvent;
  DateTime? _lastControllerEvent;
  double _yaw = 0;
  double _pitch = 0;
  double _objectYaw = 0;
  double _objectPitch = 0;
  double _objectX = 0;
  double _objectY = 0;
  double _objectZ = 0;
  double _scale = 1;
  double _distanceMeters = 1.2;
  double _fovDegrees = 70;
  double _ipdMeters = 0.064;
  double _gestureScale = 1;
  bool _locked = false;
  bool _showControls = true;
  bool _controllerConnected = false;
  String? _sensorError;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _gyroscope =
        gyroscopeEventStream(
          samplingPeriod: SensorInterval.gameInterval,
        ).listen(
          (event) {
            final now = DateTime.now();
            final previous = _lastEvent;
            _lastEvent = now;
            if (previous == null || !mounted) return;
            final seconds = now.difference(previous).inMicroseconds / 1000000;
            setState(() {
              _yaw += event.y * seconds;
              _pitch = (_pitch + event.x * seconds).clamp(
                -math.pi / 2,
                math.pi / 2,
              );
            });
          },
          onError: (Object error) {
            if (mounted) setState(() => _sensorError = '$error');
          },
        );
    _controller = const VrControllerService().events.listen(
      _onControllerEvent,
      onError: (_) {},
    );
  }

  @override
  void dispose() {
    _gyroscope?.cancel();
    _controller?.cancel();
    _focusNode.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Focus(
              focusNode: _focusNode,
              autofocus: true,
              onKeyEvent: _onKeyboardEvent,
              child: GestureDetector(
                onTap: () {
                  _focusNode.requestFocus();
                  setState(() => _showControls = !_showControls);
                },
                onScaleStart: (_) => _gestureScale = _scale,
                onScaleUpdate: _locked
                    ? null
                    : (details) {
                        setState(() {
                          if (details.pointerCount > 1) {
                            _scale = (_gestureScale * details.scale).clamp(
                              0.05,
                              20,
                            );
                          } else {
                            _objectYaw += details.focalPointDelta.dx / 180;
                            _objectPitch += details.focalPointDelta.dy / 180;
                          }
                        });
                      },
                child: CustomPaint(
                  painter: _StereoMeshPainter(
                    mesh: widget.mesh,
                    sourceTransform: widget.transform,
                    headYaw: _yaw,
                    headPitch: _pitch,
                    objectYaw: _objectYaw,
                    objectPitch: _objectPitch,
                    objectX: _objectX,
                    objectY: _objectY,
                    objectZ: _objectZ,
                    scale: _scale,
                    distanceMeters: _distanceMeters,
                    fieldOfViewDegrees: _fovDegrees,
                    interpupillaryDistanceMeters: _ipdMeters,
                  ),
                ),
              ),
            ),
          ),
          if (_showControls)
            Positioned(
              left: 12,
              right: 12,
              top: 12,
              child: Card(
                color: const Color(0xDD10192B),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: 'Apply changes and exit VR',
                        onPressed: _applyAndExit,
                        icon: const Icon(Icons.close),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Stereoscopic VR · gyroscope head tracking · controller ready',
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 70,
                                  child: Text('Distance'),
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _distanceMeters,
                                    min: 0.2,
                                    max: 5,
                                    onChanged: (value) =>
                                        setState(() => _distanceMeters = value),
                                  ),
                                ),
                                Text('${_distanceMeters.toStringAsFixed(1)} m'),
                                const SizedBox(width: 12),
                                const SizedBox(width: 40, child: Text('FOV')),
                                Expanded(
                                  child: Slider(
                                    value: _fovDegrees,
                                    min: 45,
                                    max: 100,
                                    onChanged: (value) =>
                                        setState(() => _fovDegrees = value),
                                  ),
                                ),
                                Text('${_fovDegrees.round()}°'),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 70,
                                  child: Text('Eye spacing'),
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _ipdMeters,
                                    min: 0.05,
                                    max: 0.075,
                                    onChanged: (value) =>
                                        setState(() => _ipdMeters = value),
                                  ),
                                ),
                                Text('${(_ipdMeters * 1000).round()} mm'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      FilterChip(
                        selected: _locked,
                        onSelected: (value) => setState(() => _locked = value),
                        avatar: Icon(_locked ? Icons.lock : Icons.lock_open),
                        label: const Text('Lock object'),
                      ),
                      IconButton(
                        tooltip: 'Reset head and object',
                        onPressed: () => setState(() {
                          _yaw = 0;
                          _pitch = 0;
                          _objectYaw = 0;
                          _objectPitch = 0;
                          _objectX = 0;
                          _objectY = 0;
                          _objectZ = 0;
                          _scale = 1;
                        }),
                        icon: const Icon(Icons.restart_alt),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 8,
            child: Text(
              _sensorError == null
                  ? _controllerConnected
                        ? 'Controller: left stick/D-pad move · right stick rotates · triggers resize · A locks · B resets.'
                        : 'Touch: drag to rotate, pinch to resize. Keyboard: WASD move, Q/E depth, arrows rotate, +/- resize. Bluetooth/USB gamepads connect automatically.'
                  : 'Gyroscope unavailable: $_sensorError',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  KeyEventResult _onKeyboardEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.space) {
      setState(() => _locked = !_locked);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.keyR) {
      _resetObject();
      return KeyEventResult.handled;
    }
    if (_locked) return KeyEventResult.ignored;
    setState(() {
      if (key == LogicalKeyboardKey.keyA) _objectX -= 0.05;
      if (key == LogicalKeyboardKey.keyD) _objectX += 0.05;
      if (key == LogicalKeyboardKey.keyW) _objectY += 0.05;
      if (key == LogicalKeyboardKey.keyS) _objectY -= 0.05;
      if (key == LogicalKeyboardKey.keyQ) _objectZ -= 0.05;
      if (key == LogicalKeyboardKey.keyE) _objectZ += 0.05;
      if (key == LogicalKeyboardKey.arrowLeft) _objectYaw -= 0.08;
      if (key == LogicalKeyboardKey.arrowRight) _objectYaw += 0.08;
      if (key == LogicalKeyboardKey.arrowUp) _objectPitch -= 0.08;
      if (key == LogicalKeyboardKey.arrowDown) _objectPitch += 0.08;
      if (key == LogicalKeyboardKey.equal || key == LogicalKeyboardKey.add) {
        _scale = (_scale * 1.05).clamp(0.05, 20);
      }
      if (key == LogicalKeyboardKey.minus ||
          key == LogicalKeyboardKey.numpadSubtract) {
        _scale = (_scale / 1.05).clamp(0.05, 20);
      }
      _clampObjectState();
    });
    return KeyEventResult.handled;
  }

  void _onControllerEvent(VrControllerEvent event) {
    if (!mounted) return;
    if (event.type == VrControllerEventType.key) {
      if (event.pressed != true) return;
      setState(() {
        _controllerConnected = true;
        switch (event.keyCode) {
          case 96: // A
            _locked = !_locked;
          case 97: // B
            _resetObjectState();
          case 19: // D-pad up
            if (!_locked) _objectY += 0.05;
          case 20: // D-pad down
            if (!_locked) _objectY -= 0.05;
          case 21: // D-pad left
            if (!_locked) _objectX -= 0.05;
          case 22: // D-pad right
            if (!_locked) _objectX += 0.05;
          case 99: // X
            if (!_locked) _scale = (_scale / 1.05).clamp(0.05, 20);
          case 100: // Y
            if (!_locked) _scale = (_scale * 1.05).clamp(0.05, 20);
          case 102: // L1
            if (!_locked) _objectZ -= 0.05;
          case 103: // R1
            if (!_locked) _objectZ += 0.05;
          case 108: // Start
            _showControls = !_showControls;
        }
        _clampObjectState();
      });
      return;
    }

    final now = DateTime.now();
    final previous = _lastControllerEvent;
    _lastControllerEvent = now;
    final seconds = previous == null
        ? 1 / 60
        : (now.difference(previous).inMicroseconds / 1000000).clamp(
            1 / 240,
            0.1,
          );
    setState(() {
      _controllerConnected = true;
      if (_locked) return;
      final leftX = _deadZone(event.leftX);
      final leftY = _deadZone(event.leftY);
      final rightX = _deadZone(event.rightX);
      final rightY = _deadZone(event.rightY);
      _objectX += (leftX + event.hatX) * seconds * 0.8;
      _objectZ += (leftY + event.hatY) * seconds * 0.8;
      _objectYaw += rightX * seconds * 2.4;
      _objectPitch += rightY * seconds * 2.4;
      final zoom = event.rightTrigger - event.leftTrigger;
      if (zoom.abs() > 0.02) {
        _scale = (_scale * math.exp(zoom * seconds)).clamp(0.05, 20);
      }
      _clampObjectState();
    });
  }

  double _deadZone(double value) => value.abs() < 0.15 ? 0 : value;

  void _clampObjectState() {
    _objectX = _objectX.clamp(-10, 10);
    _objectY = _objectY.clamp(-10, 10);
    _objectZ = _objectZ.clamp(-_distanceMeters + 0.1, 10);
    _objectPitch = _objectPitch.clamp(-math.pi, math.pi);
  }

  void _resetObject() => setState(_resetObjectState);

  void _resetObjectState() {
    _objectYaw = 0;
    _objectPitch = 0;
    _objectX = 0;
    _objectY = 0;
    _objectZ = 0;
    _scale = 1;
  }

  void _applyAndExit() {
    Navigator.of(context).pop(
      widget.transform.copyWith(
        positionX: widget.transform.positionX + _objectX * 1000,
        positionY: widget.transform.positionY + _objectY * 1000,
        positionZ: widget.transform.positionZ + _objectZ * 1000,
        rotationX: widget.transform.rotationX + _objectPitch * 180 / math.pi,
        rotationY: widget.transform.rotationY + _objectYaw * 180 / math.pi,
        scaleX: widget.transform.scaleX * _scale,
        scaleY: widget.transform.scaleY * _scale,
        scaleZ: widget.transform.scaleZ * _scale,
      ),
    );
  }
}

class _StereoMeshPainter extends CustomPainter {
  const _StereoMeshPainter({
    required this.mesh,
    required this.sourceTransform,
    required this.headYaw,
    required this.headPitch,
    required this.objectYaw,
    required this.objectPitch,
    required this.objectX,
    required this.objectY,
    required this.objectZ,
    required this.scale,
    required this.distanceMeters,
    required this.fieldOfViewDegrees,
    required this.interpupillaryDistanceMeters,
  });

  final MeshModel mesh;
  final ObjectTransform sourceTransform;
  final double headYaw;
  final double headPitch;
  final double objectYaw;
  final double objectPitch;
  final double objectX;
  final double objectY;
  final double objectZ;
  final double scale;
  final double distanceMeters;
  final double fieldOfViewDegrees;
  final double interpupillaryDistanceMeters;

  @override
  void paint(Canvas canvas, Size size) {
    final halfWidth = size.width / 2;
    final border = Paint()
      ..color = const Color(0xFF27D3C2)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(halfWidth, 0),
      Offset(halfWidth, size.height),
      border,
    );
    for (var eye = 0; eye < 2; eye++) {
      canvas.save();
      canvas.clipRect(
        Rect.fromLTWH(eye * halfWidth, 0, halfWidth, size.height),
      );
      _paintEye(canvas, size, eye, halfWidth);
      canvas.restore();
    }
  }

  void _paintEye(Canvas canvas, Size size, int eye, double halfWidth) {
    final object = Matrix4.identity()
      ..rotateX(sourceTransform.rotationX * math.pi / 180 + objectPitch)
      ..rotateY(sourceTransform.rotationY * math.pi / 180 + objectYaw)
      ..rotateZ(sourceTransform.rotationZ * math.pi / 180)
      ..scaleByVector3(
        Vector3(
          sourceTransform.scaleX * scale / 1000,
          sourceTransform.scaleY * scale / 1000,
          sourceTransform.scaleZ * scale / 1000,
        ),
      );
    final view = Matrix4.identity()
      ..rotateX(-headPitch)
      ..rotateY(-headYaw);
    final center = mesh.center;
    final eyeOffset = (eye == 0 ? -1 : 1) * interpupillaryDistanceMeters / 2;
    final focal =
        (size.height / 2) / math.tan(fieldOfViewDegrees * math.pi / 360);
    Offset? project(Vector3 source) {
      final point = Vector3.copy(source)..sub(center);
      object.transform3(point);
      point
        ..x += sourceTransform.positionX / 1000 + objectX - eyeOffset
        ..y += sourceTransform.positionY / 1000 + objectY
        ..z += distanceMeters + sourceTransform.positionZ / 1000 + objectZ;
      view.transform3(point);
      if (point.z <= 0.02) return null;
      return Offset(
        eye * halfWidth + halfWidth / 2 + point.x / point.z * focal,
        size.height / 2 - point.y / point.z * focal,
      );
    }

    final paint = Paint()
      ..color = const Color(0xFFBFEFEB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final stride = math.max(1, (mesh.triangles.length / 2200).ceil());
    for (
      var faceIndex = 0;
      faceIndex < mesh.triangles.length;
      faceIndex += stride
    ) {
      final face = mesh.triangles[faceIndex];
      if (face.length < 3) continue;
      final points = [
        for (final index in face.take(3)) project(mesh.vertices[index]),
      ];
      if (points.any((point) => point == null)) continue;
      final path = Path()..moveTo(points[0]!.dx, points[0]!.dy);
      path
        ..lineTo(points[1]!.dx, points[1]!.dy)
        ..lineTo(points[2]!.dx, points[2]!.dy)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StereoMeshPainter oldDelegate) => true;
}
