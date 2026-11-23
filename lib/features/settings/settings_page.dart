import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drift/drift.dart' show Value;

import '../../core/backup/backup_service.dart';
import '../../core/database/app_database.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({required this.database, super.key});

  final AppDatabase database;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _busy = false;
  String? _message;
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
