import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';

class BackupService {
  const BackupService(this.database);

  final AppDatabase database;

  Future<String> createBackup() async {
    final payload = <String, Object?>{
      'schemaVersion': 2,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'materials': (await database.select(database.materialProfiles).get())
          .map((row) => row.toJson())
          .toList(),
      'spools': (await database.select(database.spools).get())
          .map((row) => row.toJson())
          .toList(),
      'printers': (await database.select(database.printerProfiles).get())
          .map((row) => row.toJson())
          .toList(),
      'customers': (await database.select(database.customers).get())
          .map((row) => row.toJson())
          .toList(),
      'quotes': (await database.select(database.quotes).get())
          .map((row) => row.toJson())
          .toList(),
      'quoteRevisions': (await database.select(database.quoteRevisions).get())
          .map((row) => row.toJson())
          .toList(),
      'jobs': (await database.select(database.jobs).get())
          .map((row) => row.toJson())
          .toList(),
      'printAttempts': (await database.select(database.printAttempts).get())
          .map((row) => row.toJson())
          .toList(),
      'inventoryTransactions':
          (await database.select(database.inventoryTransactions).get())
              .map((row) => row.toJson())
              .toList(),
      'marketplacePresets':
          (await database.select(database.marketplacePresets).get())
              .map((row) => row.toJson())
              .toList(),
      'businessProfiles':
          (await database.select(database.businessProfiles).get())
              .map((row) => row.toJson())
              .toList(),
      'backupMetadata': (await database.select(database.backupMetadata).get())
          .map((row) => row.toJson())
          .toList(),
      'settings': (await database.select(database.appSettings).get())
          .map((row) => row.toJson())
          .toList(),
    };
    final payloadJson = jsonEncode(payload);
    final digest = sha256.convert(utf8.encode(payloadJson)).toString();
    await database
        .into(database.backupMetadata)
        .insert(
          BackupMetadataCompanion.insert(
            id: const Uuid().v4(),
            schemaVersion: 2,
            sha256Hex: digest,
          ),
        );
    return const JsonEncoder.withIndent('  ').convert({
      'format': 'filarithm-backup',
      'sha256': digest,
      'payload': payload,
    });
  }

  Future<void> restoreBackup(String source) async {
    final root = jsonDecode(source) as Map<String, dynamic>;
    if (root['format'] != 'filarithm-backup') {
      throw const FormatException('This is not a Filarithm backup.');
    }
    final payload = root['payload'] as Map<String, dynamic>?;
    final payloadVersion = payload?['schemaVersion'];
    if (payload == null || (payloadVersion != 1 && payloadVersion != 2)) {
      throw const FormatException('The backup schema is unsupported.');
    }
    final expected = root['sha256'] as String?;
    final actual = sha256.convert(utf8.encode(jsonEncode(payload))).toString();
    if (expected == null || expected != actual) {
      throw const FormatException('Backup SHA-256 verification failed.');
    }
    List<Map<String, dynamic>> rows(String key) =>
        (payload[key] as List<dynamic>? ?? const [])
            .cast<Map<String, dynamic>>();

    await database.transaction(() async {
      await database.batch((batch) {
        batch.deleteAll(database.inventoryTransactions);
        batch.deleteAll(database.printAttempts);
        batch.deleteAll(database.jobs);
        batch.deleteAll(database.quoteRevisions);
        batch.deleteAll(database.quotes);
        batch.deleteAll(database.spools);
        batch.deleteAll(database.customers);
        batch.deleteAll(database.printerProfiles);
        batch.deleteAll(database.materialProfiles);
        batch.deleteAll(database.marketplacePresets);
        batch.deleteAll(database.businessProfiles);
        batch.deleteAll(database.backupMetadata);
        batch.deleteAll(database.appSettings);
      });
      await database.batch((batch) {
        batch.insertAll(
          database.materialProfiles,
          rows('materials').map(MaterialProfile.fromJson).toList(),
        );
        batch.insertAll(
          database.printerProfiles,
          rows('printers').map(PrinterProfile.fromJson).toList(),
        );
        batch.insertAll(
          database.customers,
          rows('customers').map(Customer.fromJson).toList(),
        );
        batch.insertAll(
          database.spools,
          rows('spools').map(Spool.fromJson).toList(),
        );
        batch.insertAll(
          database.quotes,
          rows('quotes').map(Quote.fromJson).toList(),
        );
        batch.insertAll(
          database.quoteRevisions,
          rows('quoteRevisions').map(QuoteRevision.fromJson).toList(),
        );
        batch.insertAll(database.jobs, rows('jobs').map(Job.fromJson).toList());
        batch.insertAll(
          database.printAttempts,
          rows('printAttempts').map(PrintAttempt.fromJson).toList(),
        );
        batch.insertAll(
          database.inventoryTransactions,
          rows('inventoryTransactions')
              .map(InventoryTransaction.fromJson)
              .toList(),
        );
        batch.insertAll(
          database.marketplacePresets,
          rows('marketplacePresets').map(MarketplacePreset.fromJson).toList(),
        );
        batch.insertAll(
          database.businessProfiles,
          rows('businessProfiles').map(BusinessProfile.fromJson).toList(),
        );
        batch.insertAll(
          database.backupMetadata,
          rows('backupMetadata').map(BackupMetadataData.fromJson).toList(),
        );
        batch.insertAll(
          database.appSettings,
          rows('settings').map(AppSetting.fromJson).toList(),
        );
      });
    });
    await database
        .into(database.backupMetadata)
        .insert(
          BackupMetadataCompanion.insert(
            id: const Uuid().v4(),
            schemaVersion: payloadVersion as int,
            sha256Hex: actual,
            restoredAt: Value(DateTime.now()),
          ),
        );
  }

  Future<String> exportJobsCsv() async {
    final jobs = await database.select(database.jobs).get();
    final quotes = await database.select(database.quotes).get();
    final rows = <List<dynamic>>[
      [
        'Type',
        'ID',
        'Reference',
        'Status',
        'Subtotal AED',
        'Tax AED',
        'Total AED',
        'Created',
      ],
      for (final quote in quotes)
        [
          'Quote',
          quote.id,
          quote.quoteNumber,
          quote.status,
          quote.subtotalMicros / 1000000,
          quote.taxMicros / 1000000,
          quote.totalMicros / 1000000,
          quote.createdAt.toIso8601String(),
        ],
      for (final job in jobs)
        [
          'Job',
          job.id,
          job.sourceName ?? '',
          job.state,
          '',
          '',
          '',
          job.createdAt.toIso8601String(),
        ],
    ];
    return Csv(lineDelimiter: '\n').encode(rows);
  }
}
