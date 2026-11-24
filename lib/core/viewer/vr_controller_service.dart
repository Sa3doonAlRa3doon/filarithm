import 'package:flutter/services.dart';

enum VrControllerEventType { axes, key }

class VrControllerEvent {
  const VrControllerEvent.axes({
    required this.leftX,
    required this.leftY,
    required this.rightX,
    required this.rightY,
    required this.hatX,
    required this.hatY,
    required this.leftTrigger,
    required this.rightTrigger,
  }) : type = VrControllerEventType.axes,
       keyCode = null,
       pressed = null;

  const VrControllerEvent.key({required this.keyCode, required this.pressed})
    : type = VrControllerEventType.key,
      leftX = 0,
      leftY = 0,
      rightX = 0,
      rightY = 0,
      hatX = 0,
      hatY = 0,
      leftTrigger = 0,
      rightTrigger = 0;

  final VrControllerEventType type;
  final double leftX;
  final double leftY;
  final double rightX;
  final double rightY;
  final double hatX;
  final double hatY;
  final double leftTrigger;
  final double rightTrigger;
  final int? keyCode;
  final bool? pressed;

  static VrControllerEvent? fromMessage(Object? message) {
    if (message is! Map) return null;
    final type = message['type'];
    if (type == 'axes') {
      return VrControllerEvent.axes(
        leftX: _axis(message['leftX']),
        leftY: _axis(message['leftY']),
        rightX: _axis(message['rightX']),
        rightY: _axis(message['rightY']),
        hatX: _axis(message['hatX']),
        hatY: _axis(message['hatY']),
        leftTrigger: _trigger(message['leftTrigger']),
        rightTrigger: _trigger(message['rightTrigger']),
      );
    }
    if (type == 'key' && message['keyCode'] is num) {
      return VrControllerEvent.key(
        keyCode: (message['keyCode'] as num).toInt(),
        pressed: message['pressed'] == true,
      );
    }
    return null;
  }

  static double _axis(Object? value) =>
      ((value as num?)?.toDouble() ?? 0).clamp(-1, 1);

  static double _trigger(Object? value) =>
      ((value as num?)?.toDouble() ?? 0).clamp(0, 1);
}

class VrControllerService {
  const VrControllerService();

  static const _channel = EventChannel('ae.aveonex.filarithm/vr_controller');

  Stream<VrControllerEvent> get events => _channel
      .receiveBroadcastStream()
      .map(VrControllerEvent.fromMessage)
      .where((event) => event != null)
      .cast<VrControllerEvent>();
}
