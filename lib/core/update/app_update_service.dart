import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

enum UpdateTarget {
  androidArm64,
  androidArmV7,
  ubuntu2204,
  ubuntu2404,
  ubuntu2604,
  unsupported,
}

class UpdateAsset {
  const UpdateAsset({
    required this.name,
    required this.downloadUri,
    required this.sizeBytes,
    this.sha256Hex,
  });

  final String name;
  final Uri downloadUri;
  final int sizeBytes;
  final String? sha256Hex;

  UpdateAsset copyWith({String? sha256Hex}) => UpdateAsset(
    name: name,
    downloadUri: downloadUri,
    sizeBytes: sizeBytes,
    sha256Hex: sha256Hex ?? this.sha256Hex,
  );
}

class UpdateRelease {
  const UpdateRelease({
    required this.currentVersion,
    required this.latestVersion,
    required this.releaseUri,
    required this.notes,
    required this.isAvailable,
    required this.asset,
    this.publishedAt,
  });

  final String currentVersion;
  final String latestVersion;
  final Uri releaseUri;
  final String notes;
  final bool isAvailable;
  final UpdateAsset? asset;
  final DateTime? publishedAt;

  UpdateRelease copyWith({UpdateAsset? asset}) => UpdateRelease(
    currentVersion: currentVersion,
    latestVersion: latestVersion,
    releaseUri: releaseUri,
    notes: notes,
    isAvailable: isAvailable,
    asset: asset ?? this.asset,
    publishedAt: publishedAt,
  );
}

class UpdateException implements Exception {
  const UpdateException(this.message);

  final String message;

  @override
  String toString() => message;
}

typedef DownloadProgress = void Function(int receivedBytes, int totalBytes);

class AppUpdateService {
  AppUpdateService({
    Uri? latestReleaseUri,
    HttpClient Function()? httpClientFactory,
  }) : latestReleaseUri =
           latestReleaseUri ??
           Uri.https(
             'api.github.com',
             '/repos/Sa3doonAlRa3doon/filarithm/releases/latest',
           ),
       _httpClientFactory = httpClientFactory ?? HttpClient.new;

  final Uri latestReleaseUri;
  final HttpClient Function() _httpClientFactory;

  Future<UpdateRelease> checkForUpdates({
    required String currentVersion,
    required UpdateTarget target,
  }) async {
    final payload = await _getJson(latestReleaseUri);
    var release = parseRelease(
      payload,
      currentVersion: currentVersion,
      target: target,
    );
    if (release.asset == null || release.asset!.sha256Hex != null) {
      return release;
    }

    final assets = payload['assets'];
    if (assets is! List<dynamic>) return release;
    final checksumAsset = assets
        .whereType<Map<String, dynamic>>()
        .where(
          (asset) => asset['name'].toString().toLowerCase() == 'sha256sums.txt',
        )
        .firstOrNull;
    if (checksumAsset == null) return release;
    final checksumUri = Uri.tryParse(
      checksumAsset['browser_download_url']?.toString() ?? '',
    );
    if (checksumUri == null) return release;
    final checksums = await _getText(checksumUri);
    final digest = checksumForAsset(checksums, release.asset!.name);
    if (digest != null) {
      release = release.copyWith(
        asset: release.asset!.copyWith(sha256Hex: digest),
      );
    }
    return release;
  }

  UpdateRelease parseRelease(
    Map<String, dynamic> payload, {
    required String currentVersion,
    required UpdateTarget target,
  }) {
    if (payload['draft'] == true || payload['prerelease'] == true) {
      throw const UpdateException(
        'The latest GitHub response is not a stable published release.',
      );
    }
    final tag = payload['tag_name']?.toString().trim() ?? '';
    final latestVersion = _cleanVersion(tag);
    if (latestVersion.isEmpty) {
      throw const UpdateException('The release has no valid version tag.');
    }
    final releaseUri = Uri.tryParse(payload['html_url']?.toString() ?? '');
    if (releaseUri == null || !releaseUri.hasScheme) {
      throw const UpdateException('The release has no valid GitHub URL.');
    }
    final assets = payload['assets'];
    final candidates = assets is List<dynamic>
        ? assets.whereType<Map<String, dynamic>>().toList()
        : const <Map<String, dynamic>>[];
    final selected = _selectAsset(candidates, target);
    return UpdateRelease(
      currentVersion: currentVersion,
      latestVersion: latestVersion,
      releaseUri: releaseUri,
      notes: payload['body']?.toString().trim() ?? '',
      publishedAt: DateTime.tryParse(payload['published_at']?.toString() ?? ''),
      isAvailable: compareVersions(latestVersion, currentVersion) > 0,
      asset: selected,
    );
  }

  Future<File> downloadVerified(
    UpdateAsset asset,
    File destination, {
    DownloadProgress? onProgress,
  }) async {
    final expectedDigest = asset.sha256Hex?.toLowerCase();
    if (expectedDigest == null ||
        !RegExp(r'^[0-9a-f]{64}$').hasMatch(expectedDigest)) {
      throw const UpdateException(
        'This release asset has no trusted SHA-256 checksum.',
      );
    }
    await destination.parent.create(recursive: true);
    final partial = File('${destination.path}.part');
    if (await partial.exists()) await partial.delete();
    final client = _httpClientFactory();
    IOSink? output;
    try {
      final request = await client.getUrl(asset.downloadUri);
      _applyHeaders(request);
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        throw UpdateException(
          'Update download failed with HTTP ${response.statusCode}.',
        );
      }
      final digestSink = _DigestSink();
      final hashingSink = sha256.startChunkedConversion(digestSink);
      output = partial.openWrite();
      var received = 0;
      final total = response.contentLength > 0
          ? response.contentLength
          : asset.sizeBytes;
      await for (final chunk in response) {
        hashingSink.add(chunk);
        output.add(chunk);
        received += chunk.length;
        onProgress?.call(received, total);
      }
      hashingSink.close();
      await output.flush();
      await output.close();
      output = null;
      if (asset.sizeBytes > 0 && received != asset.sizeBytes) {
        throw UpdateException(
          'Update size mismatch: expected ${asset.sizeBytes} bytes, received $received.',
        );
      }
      final actualDigest = digestSink.value.toString().toLowerCase();
      if (actualDigest != expectedDigest) {
        throw const UpdateException(
          'Update SHA-256 verification failed. The file was deleted.',
        );
      }
      if (await destination.exists()) await destination.delete();
      return await partial.rename(destination.path);
    } catch (_) {
      await output?.close();
      if (await partial.exists()) await partial.delete();
      rethrow;
    } finally {
      client.close(force: true);
    }
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    final body = await _getText(uri);
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const UpdateException('GitHub returned an unexpected response.');
    }
    return decoded;
  }

  Future<String> _getText(Uri uri) async {
    final client = _httpClientFactory();
    try {
      final request = await client.getUrl(uri);
      _applyHeaders(request);
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        throw UpdateException(
          'GitHub update check failed with HTTP ${response.statusCode}.',
        );
      }
      return await response.transform(utf8.decoder).join();
    } finally {
      client.close(force: true);
    }
  }

  void _applyHeaders(HttpClientRequest request) {
    request.headers
      ..set(HttpHeaders.acceptHeader, 'application/vnd.github+json')
      ..set(HttpHeaders.userAgentHeader, 'Filarithm-Update/1.0')
      ..set('X-GitHub-Api-Version', '2022-11-28');
  }

  UpdateAsset? _selectAsset(
    List<Map<String, dynamic>> assets,
    UpdateTarget target,
  ) {
    final parsed = assets.map(_assetFromJson).whereType<UpdateAsset>().toList();
    bool apk(UpdateAsset asset) => asset.name.toLowerCase().endsWith('.apk');
    bool has(UpdateAsset asset, String value) =>
        asset.name.toLowerCase().contains(value);
    UpdateAsset? firstWhere(bool Function(UpdateAsset) test) =>
        parsed.where(test).firstOrNull;

    return switch (target) {
      UpdateTarget.androidArm64 =>
        firstWhere(
              (asset) =>
                  apk(asset) &&
                  !has(asset, 'mobile-arm64-armv7') &&
                  (has(asset, 'arm64-v8a') ||
                      RegExp(r'-arm64\.apk$')
                          .hasMatch(asset.name.toLowerCase())),
            ) ??
            firstWhere(
              (asset) => apk(asset) && has(asset, 'mobile-arm64-armv7'),
            ),
      UpdateTarget.androidArmV7 =>
        firstWhere(
              (asset) =>
                  apk(asset) &&
                  !has(asset, 'mobile-arm64-armv7') &&
                  (has(asset, 'armeabi-v7a') ||
                      RegExp(r'-armv7\.apk$')
                          .hasMatch(asset.name.toLowerCase())),
            ) ??
            firstWhere(
              (asset) => apk(asset) && has(asset, 'mobile-arm64-armv7'),
            ),
      UpdateTarget.ubuntu2204 => firstWhere(
        (asset) => has(asset, 'ubuntu-22.04') && has(asset, '_amd64.deb'),
      ),
      UpdateTarget.ubuntu2404 => firstWhere(
        (asset) => has(asset, 'ubuntu-24.04') && has(asset, '_amd64.deb'),
      ),
      UpdateTarget.ubuntu2604 => firstWhere(
        (asset) => has(asset, 'ubuntu-26.04') && has(asset, '_amd64.deb'),
      ),
      UpdateTarget.unsupported => null,
    };
  }

  UpdateAsset? _assetFromJson(Map<String, dynamic> value) {
    final name = value['name']?.toString() ?? '';
    final uri = Uri.tryParse(value['browser_download_url']?.toString() ?? '');
    if (name.isEmpty || uri == null || !uri.hasScheme) return null;
    final rawDigest = value['digest']?.toString().trim().toLowerCase();
    final digest = rawDigest != null && rawDigest.startsWith('sha256:')
        ? rawDigest.substring('sha256:'.length)
        : null;
    return UpdateAsset(
      name: name,
      downloadUri: uri,
      sizeBytes: (value['size'] as num?)?.toInt() ?? 0,
      sha256Hex: digest,
    );
  }

  static int compareVersions(String left, String right) {
    final leftParts = _versionParts(left);
    final rightParts = _versionParts(right);
    final length = leftParts.length > rightParts.length
        ? leftParts.length
        : rightParts.length;
    for (var index = 0; index < length; index++) {
      final leftValue = index < leftParts.length ? leftParts[index] : 0;
      final rightValue = index < rightParts.length ? rightParts[index] : 0;
      if (leftValue != rightValue) return leftValue.compareTo(rightValue);
    }
    return 0;
  }

  static List<int> _versionParts(String value) {
    final match = RegExp(r'\d+(?:\.\d+)*').firstMatch(_cleanVersion(value));
    return match
            ?.group(0)
            ?.split('.')
            .map((part) => int.tryParse(part) ?? 0)
            .toList() ??
        const [0];
  }

  static String _cleanVersion(String value) =>
      value.trim().replaceFirst(RegExp(r'^[vV]'), '').split('+').first;

  static String? checksumForAsset(String checksums, String assetName) {
    for (final line in const LineSplitter().convert(checksums)) {
      final match = RegExp(r'^([0-9a-fA-F]{64})\s+\*?(.+?)\s*$')
          .firstMatch(line);
      if (match != null && match.group(2) == assetName) {
        return match.group(1)!.toLowerCase();
      }
    }
    return null;
  }
}

class _DigestSink implements Sink<Digest> {
  Digest? _value;

  Digest get value =>
      _value ?? (throw StateError('The digest has not been finalized.'));

  @override
  void add(Digest data) {
    if (_value != null) throw StateError('Only one digest is expected.');
    _value = data;
  }

  @override
  void close() {}
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    return iterator.moveNext() ? iterator.current : null;
  }
}
