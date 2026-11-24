import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:filarithm/core/update/app_update_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final service = AppUpdateService();

  test('selects the exact ABI asset and detects a newer stable release', () {
    final release = service.parseRelease(
      _releasePayload(),
      currentVersion: '1.0.0',
      target: UpdateTarget.androidArm64,
    );

    expect(release.latestVersion, '1.2.0');
    expect(release.isAvailable, isTrue);
    expect(release.asset?.name, 'filarithm-1.2.0-arm64-v8a.apk');
    expect(release.asset?.sha256Hex, 'a' * 64);
  });

  test('selects the matching Ubuntu package and rejects prereleases', () {
    final release = service.parseRelease(
      _releasePayload(),
      currentVersion: '1.2.0',
      target: UpdateTarget.ubuntu2404,
    );
    expect(release.isAvailable, isFalse);
    expect(release.asset?.name, 'filarithm_1.2.0_ubuntu-24.04_amd64.deb');

    expect(
      () => service.parseRelease(
        {..._releasePayload(), 'prerelease': true},
        currentVersion: '1.0.0',
        target: UpdateTarget.androidArm64,
      ),
      throwsA(isA<UpdateException>()),
    );
  });

  test('parses release checksum files by exact asset name', () {
    final checksum = AppUpdateService.checksumForAsset(
      '${'b' * 64}  first.apk\n${'c' * 64} *second.apk\n',
      'second.apk',
    );
    expect(checksum, 'c' * 64);
    expect(
      AppUpdateService.checksumForAsset('${'d' * 64}  other.apk', 'app.apk'),
      isNull,
    );
  });

  test('compares release versions numerically', () {
    expect(AppUpdateService.compareVersions('1.10.0', '1.9.9'), greaterThan(0));
    expect(AppUpdateService.compareVersions('v1.0.1+7', '1.0.1'), 0);
    expect(AppUpdateService.compareVersions('1.0.0', '1.0.1'), lessThan(0));
  });

  test(
    'downloads to a partial file and verifies SHA-256 before rename',
    () async {
      final bytes = utf8.encode('signed release payload');
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((request) async {
        request.response
          ..statusCode = HttpStatus.ok
          ..contentLength = bytes.length
          ..add(bytes);
        await request.response.close();
      });
      final directory = await Directory.systemTemp.createTemp(
        'filarithm-update-test-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final destination = File('${directory.path}/update.apk');
      final asset = UpdateAsset(
        name: 'update.apk',
        downloadUri: Uri.parse(
          'http://${server.address.address}:${server.port}/update.apk',
        ),
        sizeBytes: bytes.length,
        sha256Hex: sha256.convert(bytes).toString(),
      );

      final downloaded = await service.downloadVerified(asset, destination);

      expect(await downloaded.readAsBytes(), bytes);
      expect(await File('${destination.path}.part').exists(), isFalse);
    },
  );

  test('deletes a download when SHA-256 verification fails', () async {
    final bytes = utf8.encode('tampered payload');
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    server.listen((request) async {
      request.response
        ..statusCode = HttpStatus.ok
        ..contentLength = bytes.length
        ..add(bytes);
      await request.response.close();
    });
    final directory = await Directory.systemTemp.createTemp(
      'filarithm-update-fail-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final destination = File('${directory.path}/update.apk');
    final asset = UpdateAsset(
      name: 'update.apk',
      downloadUri: Uri.parse(
        'http://${server.address.address}:${server.port}/update.apk',
      ),
      sizeBytes: bytes.length,
      sha256Hex: '0' * 64,
    );

    await expectLater(
      service.downloadVerified(asset, destination),
      throwsA(isA<UpdateException>()),
    );
    expect(await destination.exists(), isFalse);
    expect(await File('${destination.path}.part').exists(), isFalse);
  });
}

Map<String, dynamic> _releasePayload() => {
  'tag_name': 'v1.2.0',
  'html_url':
      'https://github.com/Sa3doonAlRa3doon/filarithm/releases/tag/v1.2.0',
  'body': 'Offline updater release',
  'published_at': '2026-11-24T00:00:00Z',
  'draft': false,
  'prerelease': false,
  'assets': [
    {
      'name': 'filarithm-1.2.0-arm64-v8a.apk',
      'browser_download_url': 'https://example.invalid/arm64.apk',
      'size': 123,
      'digest': 'sha256:${'a' * 64}',
    },
    {
      'name': 'filarithm-1.2.0-armeabi-v7a.apk',
      'browser_download_url': 'https://example.invalid/armv7.apk',
      'size': 120,
      'digest': 'sha256:${'b' * 64}',
    },
    {
      'name': 'filarithm-1.2.0-mobile-arm64-armv7.apk',
      'browser_download_url': 'https://example.invalid/mobile.apk',
      'size': 200,
      'digest': 'sha256:${'c' * 64}',
    },
    {
      'name': 'filarithm_1.2.0_ubuntu-24.04_amd64.deb',
      'browser_download_url': 'https://example.invalid/filarithm.deb',
      'size': 400,
      'digest': 'sha256:${'d' * 64}',
    },
  ],
};
