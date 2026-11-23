import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:filarithm/core/backup/backup_service.dart';
import 'package:filarithm/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late BackupService service;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    service = BackupService(database);
  });

  tearDown(() => database.close());

  test('round-trips local data through a verified backup', () async {
    await database
        .into(database.materialProfiles)
        .insert(
          MaterialProfilesCompanion.insert(
            id: 'pink',
            name: 'Pink PLA',
            materialType: 'PLA',
            colorHex: '#FF69B4',
            spoolPriceMicros: 100000000,
            nominalMassMg: 1000000,
          ),
        );
    await database
        .into(database.spools)
        .insert(
          SpoolsCompanion.insert(
            id: 'spool-a',
            materialProfileId: 'pink',
            remainingMassMg: 750000,
          ),
        );

    final backup = await service.createBackup();
    await database.delete(database.spools).go();
    await database.delete(database.materialProfiles).go();
    await service.restoreBackup(backup);

    expect(
      await database.select(database.materialProfiles).get(),
      hasLength(1),
    );
    expect(
      (await database.select(database.spools).get()).single.remainingMassMg,
      750000,
    );
  });

  test('rejects payload tampering', () async {
    final root =
        jsonDecode(await service.createBackup()) as Map<String, dynamic>;
    final payload = root['payload'] as Map<String, dynamic>;
    payload['createdAt'] = 'tampered';

    expect(
      () => service.restoreBackup(jsonEncode(root)),
      throwsFormatException,
    );
  });

  test('CSV export has stable business columns', () async {
    await database
        .into(database.jobs)
        .insert(
          JobsCompanion.insert(
            id: 'job-1',
            projectJson: '{}',
            sourceName: const Value('bracket.3mf'),
          ),
        );
    final csv = await service.exportJobsCsv();
    expect(csv, contains('Type,ID,Reference,Status'));
    expect(csv, contains('bracket.3mf'));
  });
}
