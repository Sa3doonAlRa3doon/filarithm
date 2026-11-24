import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drift/drift.dart' show Value;
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/backup/backup_service.dart';
import '../../core/database/app_database.dart';
import '../../core/update/app_update_service.dart';
import '../../core/update/update_platform_bridge.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({required this.database, super.key});

  final AppDatabase database;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _busy = false;
  String? _message;
  bool _updateBusy = false;
  String? _updateMessage;
  double? _updateProgress;
  PackageInfo? _packageInfo;
  UpdateTarget? _updateTarget;
  UpdateRelease? _updateRelease;
  String? _downloadedUpdatePath;
  final _updateService = AppUpdateService();
  final _updateBridge = const UpdatePlatformBridge();
  final _businessName = TextEditingController(text: 'AVEONEX');
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _addressEnglish = TextEditingController();
  final _addressArabic = TextEditingController();
  final _trn = TextEditingController();
  final _vatPercent = TextEditingController(text: '5');
  final _termsEnglish = TextEditingController();
  final _termsArabic = TextEditingController();
  bool _vatEnabled = false;

  BackupService get _backup => BackupService(widget.database);

  @override
  void initState() {
    super.initState();
    _loadBusinessProfile();
    _loadUpdateInfo();
  }

  @override
  void dispose() {
    for (final controller in [
      _businessName,
      _phone,
      _email,
      _addressEnglish,
      _addressArabic,
      _trn,
      _vatPercent,
      _termsEnglish,
      _termsArabic,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings & data')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Privacy-first data management',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'All workshop data stays in the local SQLite database. No account, cloud server, telemetry or advertisements.',
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.backup_outlined),
                  title: const Text('Export verified backup'),
                  subtitle: const Text(
                    'Schema-versioned JSON with SHA-256 integrity check',
                  ),
                  onTap: _busy ? null : _exportBackup,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.restore),
                  title: const Text('Restore backup'),
                  subtitle: const Text(
                    'Verifies SHA-256 before replacing local data',
                  ),
                  onTap: _busy ? null : _restoreBackup,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.table_view_outlined),
                  title: const Text('Export jobs & quotes CSV'),
                  onTap: _busy ? null : _exportCsv,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _updateCard(context),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Business & quotation profile',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _businessField(_businessName, 'Business name'),
                      _businessField(_phone, 'Phone'),
                      _businessField(_email, 'Email'),
                      _businessField(_addressEnglish, 'Address (English)'),
                      _businessField(_addressArabic, 'العنوان بالعربية'),
                      _businessField(_trn, 'TRN (optional)'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: _vatEnabled,
                    title: const Text('Enable VAT on new quotations'),
                    subtitle: const Text(
                      'Disabled by default. Tax Invoice wording also requires a TRN.',
                    ),
                    onChanged: (value) => setState(() => _vatEnabled = value),
                  ),
                  if (_vatEnabled)
                    Row(
                      children: [
                        _businessField(_vatPercent, 'VAT %', width: 150),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () => _vatPercent.text = '5',
                          child: const Text('UAE 5% preset'),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  _businessField(
                    _termsEnglish,
                    'Quotation terms (English)',
                    width: 520,
                  ),
                  const SizedBox(height: 10),
                  _businessField(
                    _termsArabic,
                    'شروط عرض السعر بالعربية',
                    width: 520,
                  ),
                  const SizedBox(height: 14),
                  FilledButton.icon(
                    onPressed: _busy ? null : _saveBusinessProfile,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Save business profile'),
                  ),
                ],
              ),
            ),
          ),
          if (_busy)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (_message != null)
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Text(_message!),
            ),
        ],
      ),
    );
  }

  Widget _businessField(
    TextEditingController controller,
    String label, {
    double width = 240,
  }) => SizedBox(
    width: width,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    ),
  );

  Widget _updateCard(BuildContext context) {
    final info = _packageInfo;
    final target = _updateTarget;
    final release = _updateRelease;
    final supported = target != null && target != UpdateTarget.unsupported;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.system_update_alt),
                SizedBox(width: 10),
                Text(
                  'App updates',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              info == null
                  ? 'Reading installed version…'
                  : 'Installed version ${info.version}+${info.buildNumber}',
            ),
            const SizedBox(height: 4),
            const Text(
              'Checks the public Filarithm GitHub release only when you tap the button. There is no account, background updater, companion server, or telemetry. Signed upgrades keep the local SQLite database and saved files.',
            ),
            if (target == UpdateTarget.unsupported) ...[
              const SizedBox(height: 10),
              const Text(
                'Automatic package selection is unavailable on this development ABI or unsupported Linux release. The GitHub release page can still be opened manually.',
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: _updateBusy || info == null || !supported
                      ? null
                      : _checkForUpdates,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Check for updates'),
                ),
                if (release != null)
                  OutlinedButton.icon(
                    onPressed: () => _openRelease(release.releaseUri),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open release page'),
                  ),
              ],
            ),
            if (release != null) ...[
              const SizedBox(height: 14),
              Text(
                release.isAvailable
                    ? 'Version ${release.latestVersion} is available.'
                    : 'You already have the latest stable version (${release.latestVersion}).',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              if (release.isAvailable && release.asset != null) ...[
                const SizedBox(height: 5),
                Text('Package: ${release.asset!.name}'),
                Text(
                  release.asset!.sha256Hex == null
                      ? 'The release has no usable SHA-256 checksum; installation is disabled.'
                      : 'SHA-256 will be verified before the installer opens.',
                ),
                const SizedBox(height: 10),
                FilledButton.icon(
                  onPressed: _updateBusy || release.asset!.sha256Hex == null
                      ? null
                      : _downloadAndInstallUpdate,
                  icon: Icon(
                    Platform.isAndroid
                        ? Icons.install_mobile
                        : Icons.download_for_offline_outlined,
                  ),
                  label: Text(
                    _downloadedUpdatePath != null && Platform.isAndroid
                        ? 'Continue Android installation'
                        : Platform.isAndroid
                        ? 'Download and install'
                        : 'Download Ubuntu package',
                  ),
                ),
              ],
              if (release.notes.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  release.notes.length > 700
                      ? '${release.notes.substring(0, 700)}…'
                      : release.notes,
                ),
              ],
            ],
            if (_updateProgress != null) ...[
              const SizedBox(height: 12),
              LinearProgressIndicator(value: _updateProgress),
              const SizedBox(height: 4),
              Text(
                '${(_updateProgress! * 100).toStringAsFixed(0)}% downloaded',
              ),
            ] else if (_updateBusy) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(),
            ],
            if (_updateMessage != null) ...[
              const SizedBox(height: 10),
              Text(_updateMessage!),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _loadUpdateInfo() async {
    try {
      final values = await Future.wait<Object>([
        PackageInfo.fromPlatform(),
        _updateBridge.target(),
      ]);
      if (!mounted) return;
      setState(() {
        _packageInfo = values[0] as PackageInfo;
        _updateTarget = values[1] as UpdateTarget;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _updateMessage = 'Could not read update support: $error');
    }
  }

  Future<void> _checkForUpdates() async {
    final info = _packageInfo;
    final target = _updateTarget;
    if (info == null || target == null) return;
    await _runUpdate(() async {
      final release = await _updateService.checkForUpdates(
        currentVersion: info.version,
        target: target,
      );
      if (!mounted) return;
      setState(() {
        _updateRelease = release;
        _downloadedUpdatePath = null;
        _updateMessage = release.isAvailable
            ? 'A verified package is ready to download.'
            : 'No update is required.';
      });
    });
  }

  Future<void> _downloadAndInstallUpdate() async {
    final release = _updateRelease;
    final asset = release?.asset;
    if (release == null || asset == null) return;
    await _runUpdate(() async {
      File packageFile;
      if (Platform.isAndroid && _downloadedUpdatePath != null) {
        packageFile = File(_downloadedUpdatePath!);
        if (!await packageFile.exists()) {
          _downloadedUpdatePath = null;
          packageFile = await _downloadUpdateToAndroidCache(asset);
        }
      } else if (Platform.isAndroid) {
        packageFile = await _downloadUpdateToAndroidCache(asset);
      } else if (Platform.isLinux) {
        final location = await getSaveLocation(suggestedName: asset.name);
        if (location == null) {
          if (mounted) setState(() => _updateMessage = 'Update canceled.');
          return;
        }
        packageFile = await _downloadUpdate(asset, File(location.path));
      } else {
        throw UnsupportedError('In-app installation is not supported here.');
      }

      if (Platform.isAndroid) {
        _downloadedUpdatePath = packageFile.path;
        final installResult = await _updateBridge.installAndroidApk(
          packageFile.path,
        );
        if (!mounted) return;
        setState(() {
          _updateMessage = installResult == AndroidInstallResult.launched
              ? 'Android verified the package ID, signing certificate, and newer version code. Complete the system installer to update without deleting app data.'
              : 'Allow Filarithm to install updates on the Android screen, return here, then tap Continue Android installation. Your downloaded APK remains in the private cache.';
        });
      } else {
        await OpenFilex.open(packageFile.path);
        if (!mounted) return;
        setState(() {
          _updateMessage = 'The Ubuntu package installer was opened. Upgrading the package does not remove data stored in your home directory.';
        });
      }
    });
  }

  Future<File> _downloadUpdateToAndroidCache(UpdateAsset asset) async {
    final directory = await getTemporaryDirectory();
    return _downloadUpdate(asset, File('${directory.path}/${asset.name}'));
  }

  Future<File> _downloadUpdate(UpdateAsset asset, File destination) async {
    return _updateService.downloadVerified(
      asset,
      destination,
      onProgress: (received, total) {
        if (!mounted || total <= 0) return;
        setState(() {
          _updateProgress = (received / total).clamp(0.0, 1.0);
        });
      },
    );
  }

  Future<void> _openRelease(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) &&
        mounted) {
      setState(() => _updateMessage = 'Could not open $uri');
    }
  }

  Future<void> _runUpdate(Future<void> Function() action) async {
    setState(() {
      _updateBusy = true;
      _updateProgress = null;
      _updateMessage = null;
    });
    try {
      await action();
    } catch (error) {
      if (mounted) setState(() => _updateMessage = 'Update error: $error');
    } finally {
      if (mounted) {
        setState(() {
          _updateBusy = false;
          _updateProgress = null;
        });
      }
    }
  }

  Future<void> _loadBusinessProfile() async {
    final rows = await widget.database
        .select(widget.database.businessProfiles)
        .get();
    if (rows.isEmpty || !mounted) return;
    final profile = rows.first;
    setState(() {
      _businessName.text = profile.businessName;
      _phone.text = profile.phone ?? '';
      _email.text = profile.email ?? '';
      _addressEnglish.text = profile.addressEnglish ?? '';
      _addressArabic.text = profile.addressArabic ?? '';
      _trn.text = profile.trn ?? '';
      _vatEnabled = profile.vatBasisPoints > 0;
      _vatPercent.text = (profile.vatBasisPoints / 100).toStringAsFixed(
        profile.vatBasisPoints % 100 == 0 ? 0 : 2,
      );
      _termsEnglish.text = profile.termsEnglish ?? '';
      _termsArabic.text = profile.termsArabic ?? '';
    });
  }

  Future<void> _saveBusinessProfile() async {
    await _run(() async {
      final name = _businessName.text.trim();
      if (name.isEmpty) {
        throw const FormatException('Business name is required.');
      }
      final percentage = double.tryParse(_vatPercent.text.trim());
      if (_vatEnabled && (percentage == null || percentage < 0)) {
        throw const FormatException('Enter a valid VAT percentage.');
      }
      await widget.database
          .into(widget.database.businessProfiles)
          .insertOnConflictUpdate(
            BusinessProfilesCompanion.insert(
              id: 'default',
              businessName: name,
              phone: Value(_emptyToNull(_phone.text)),
              email: Value(_emptyToNull(_email.text)),
              addressEnglish: Value(_emptyToNull(_addressEnglish.text)),
              addressArabic: Value(_emptyToNull(_addressArabic.text)),
              trn: Value(_emptyToNull(_trn.text)),
              vatBasisPoints: Value(
                _vatEnabled ? ((percentage ?? 0) * 100).round() : 0,
              ),
              termsEnglish: Value(_emptyToNull(_termsEnglish.text)),
              termsArabic: Value(_emptyToNull(_termsArabic.text)),
              updatedAt: Value(DateTime.now()),
            ),
          );
      return 'Business profile saved locally.';
    });
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<void> _exportBackup() async {
    await _run(() async {
      final location = await getSaveLocation(
        suggestedName: 'filarithm_backup.json',
      );
      if (location == null) return 'Export canceled.';
      await File(location.path)
          .writeAsString(await _backup.createBackup(), flush: true);
      return 'Backup saved to ${location.path}';
    });
  }

  Future<void> _restoreBackup() async {
    await _run(() async {
      const type = XTypeGroup(label: 'Filarithm backup', extensions: ['json']);
      final selection = await openFile(acceptedTypeGroups: [type]);
      if (selection == null) return 'Restore canceled.';
      await _backup.restoreBackup(await File(selection.path).readAsString());
      return 'Backup verified and restored.';
    });
  }

  Future<void> _exportCsv() async {
    await _run(() async {
      final location = await getSaveLocation(
        suggestedName: 'filarithm_jobs.csv',
      );
      if (location == null) return 'Export canceled.';
      await File(location.path)
          .writeAsString(await _backup.exportJobsCsv(), flush: true);
      return 'CSV saved to ${location.path}';
    });
  }

  Future<void> _run(Future<String> Function() action) async {
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final message = await action();
      if (mounted) setState(() => _message = message);
    } catch (error) {
      if (mounted) setState(() => _message = 'Error: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
