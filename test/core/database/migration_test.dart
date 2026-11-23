import 'dart:io';

import 'package:drift/native.dart';
import 'package:filarithm/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  test(
    'migrates the released v1 schema to v2 without losing old rows',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'filarithm-migration-',
      );
      final file = File('${directory.path}${Platform.pathSeparator}v1.sqlite');
      final legacy = sqlite3.open(file.path);
      legacy
        ..execute('''
        CREATE TABLE quotes (
          id TEXT NOT NULL PRIMARY KEY,
          quote_number TEXT NOT NULL UNIQUE,
          customer_id TEXT,
          status TEXT NOT NULL DEFAULT 'draft',
          currency_code TEXT NOT NULL DEFAULT 'AED',
          subtotal_micros INTEGER NOT NULL,
          tax_micros INTEGER NOT NULL,
          total_micros INTEGER NOT NULL,
          snapshot_json TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        )
      ''')
        ..execute('''
        CREATE TABLE jobs (
          id TEXT NOT NULL PRIMARY KEY,
          quote_id TEXT,
          state TEXT NOT NULL DEFAULT 'draft',
          source_name TEXT,
          project_json TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          completed_at INTEGER
        )
      ''')
        ..execute('''
        CREATE TABLE inventory_transactions (
          id TEXT NOT NULL PRIMARY KEY,
          spool_id TEXT NOT NULL,
          job_id TEXT,
          kind TEXT NOT NULL,
          delta_mass_mg INTEGER NOT NULL,
          note TEXT,
          created_at INTEGER NOT NULL
        )
      ''')
        ..execute('''
        INSERT INTO jobs (
          id, state, project_json, created_at, updated_at
        ) VALUES ('legacy-job', 'draft', '{}', 1, 1)
      ''')
        ..execute('PRAGMA user_version = 1')
        ..close();

      final database = AppDatabase.forTesting(NativeDatabase(file));
      try {
        expect(
          (await database.select(database.jobs).getSingle()).id,
          'legacy-job',
        );
        expect(await database.select(database.quoteRevisions).get(), isEmpty);
        expect(await database.select(database.printAttempts).get(), isEmpty);
        expect(
          await database.select(database.marketplacePresets).get(),
          isEmpty,
        );
        expect(await database.select(database.businessProfiles).get(), isEmpty);
        expect(await database.select(database.backupMetadata).get(), isEmpty);
        final columns = await database
            .customSelect('PRAGMA table_info(inventory_transactions)')
            .get();
        expect(
          columns.map((row) => row.read<String>('name')),
          containsAll(['attempt_id', 'reversal_of_transaction_id']),
        );
      } finally {
        await database.close();
        await directory.delete(recursive: true);
      }
    },
  );
}
