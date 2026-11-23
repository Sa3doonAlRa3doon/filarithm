import 'package:flutter/services.dart';

class ImmersiveCapability {
  const ImmersiveCapability({
    required this.arAvailable,
    required this.vrAvailable,
    this.message,
  });

  final bool arAvailable;
  final bool vrAvailable;
  final String? message;
}

class ImmersiveService {
  const ImmersiveService();

  static const _channel = MethodChannel('ae.aveonex.filarithm/immersive');

  Future<ImmersiveCapability> capability() async {
    try {
      final value = await _channel.invokeMapMethod<String, dynamic>(
        'capability',
      );
      return ImmersiveCapability(
        arAvailable: value?['ar'] == true,
        vrAvailable: value?['vr'] == true,
        message: value?['message'] as String?,
      );
    } on MissingPluginException {
      return const ImmersiveCapability(
        arAvailable: false,
        vrAvailable: false,
        message: 'No AR/OpenXR runtime bridge is installed on this platform.',
      );
    }
  }

  Future<void> enterAr(String? modelPath) =>
      _channel.invokeMethod('enterAr', {'modelPath': modelPath});

  Future<void> enterVr(String? modelPath) =>
      _channel.invokeMethod('enterVr', {'modelPath': modelPath});
}
