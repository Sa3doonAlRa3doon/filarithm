import 'dart:io';

import 'package:flutter/services.dart';

import 'app_update_service.dart';

enum AndroidInstallResult { launched, permissionRequired }

class UpdatePlatformBridge {
  const UpdatePlatformBridge();

  static const _channel = MethodChannel('ae.aveonex.filarithm/update');

  Future<UpdateTarget> target() async {
    if (Platform.isAndroid) {
      final abis =
          await _channel.invokeListMethod<String>('supportedAbis') ?? const [];
      if (abis.contains('arm64-v8a')) return UpdateTarget.androidArm64;
      if (abis.contains('armeabi-v7a')) return UpdateTarget.androidArmV7;
      return UpdateTarget.unsupported;
    }
    if (Platform.isLinux) {
      final osRelease = await File('/etc/os-release').readAsString();
      final version = RegExp(
        r'^VERSION_ID="?([^"\r\n]+)"?',
        multiLine: true,
      ).firstMatch(osRelease)?.group(1);
      return switch (version) {
        '22.04' => UpdateTarget.ubuntu2204,
        '24.04' => UpdateTarget.ubuntu2404,
        '26.04' => UpdateTarget.ubuntu2604,
        _ => UpdateTarget.unsupported,
      };
    }
    return UpdateTarget.unsupported;
  }

  Future<AndroidInstallResult> installAndroidApk(String path) async {
    if (!Platform.isAndroid) {
      throw UnsupportedError('APK installation is only available on Android.');
    }
    final allowed =
        await _channel.invokeMethod<bool>('canInstallPackages') ?? false;
    if (!allowed) {
      await _channel.invokeMethod<void>('openInstallPermission');
      return AndroidInstallResult.permissionRequired;
    }
    await _channel.invokeMethod<void>('installApk', {'filePath': path});
    return AndroidInstallResult.launched;
  }
}
