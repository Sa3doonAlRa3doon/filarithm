import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:filarithm/core/database/app_database.dart';
import 'package:filarithm/core/inventory/inventory_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late InventoryService service;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    service = InventoryService(database);
    await database
        .into(database.materialProfiles)
        .insert(
          MaterialProfilesCompanion.insert(
            id: 'black',
            name: 'Black PLA',
            materialType: 'PLA',
            colorHex: '#101010',
            spoolPriceMicros: 90000000,
            nominalMassMg: 1000000,
          ),
        );
    await database
        .into(database.spools)
        .insert(
          SpoolsCompanion.insert(
            id: 'old',
            materialProfileId: 'black',
            remainingMassMg: 250000,
            openedAt: Value(DateTime.utc(2026, 1, 1)),
          ),
        );
    await database
        .into(database.spools)
        .insert(
          SpoolsCompanion.insert(
            id: 'new',
            materialProfileId: 'black',
            remainingMassMg: 500000,
          ),
        );
    await database
        .into(database.jobs)
        .insert(JobsCompanion.insert(id: 'job', projectJson: '{}'));
  });

  tearDown(() => database.close());

  test('completion splits stock once and writes an audit ledger', () async {
    await service.completeJob(
      jobId: 'job',
      consumedMassMgByMaterial: const {'black': 400000},
    );
    final spools = await database.select(database.spools).get();
    expect(
      spools.fold<int>(0, (sum, row) => sum + row.remainingMassMg),
      350000,
    );
    expect(
      await database.select(database.inventoryTransactions).get(),
      hasLength(2),
    );
    expect(
      (await database.select(database.jobs).getSingle()).state,
      'completed',
    );
    expect(
      (await database.select(database.printAttempts).getSingle()).state,
      'completed',
    );
    expect(
      () => service.completeJob(
        jobId: 'job',
        consumedMassMgByMaterial: const {'black': 1},
      ),
      throwsStateError,
    );
  });

  test('failed print deducts waste without completing the job', () async {
    await service.logFailedPrint(
      jobId: 'job',
      materialProfileId: 'black',
      wastedMassMg: 100000,
      elapsedSeconds: 1800,
      failureReason: 'Bed adhesion',
      notes: 'Corner lifted',
    );
    expect((await database.select(database.jobs).getSingle()).state, 'draft');
    expect(
      (await database.select(database.inventoryTransactions).getSingle()).kind,
      'failed_print',
    );
    final attempt = await database.select(database.printAttempts).getSingle();
    expect(attempt.elapsedSeconds, 1800);
    expect(attempt.failureReason, 'Bed adhesion');
    expect(attempt.notes, 'Corner lifted');
  });

  test('shortfall rolls back every deduction', () async {
    expect(
      () => service.completeJob(
        jobId: 'job',
        consumedMassMgByMaterial: const {'black': 900000},
      ),
      throwsStateError,
    );
    final spools = await database.select(database.spools).get();
    expect(
      spools.fold<int>(0, (sum, row) => sum + row.remainingMassMg),
      750000,
    );
    expect(
      await database.select(database.inventoryTransactions).get(),
      isEmpty,
    );
  });

  test(
    'reprint attempts increment and ledger reversal restores stock',
    () async {
      final first = await service.startAttempt(
        jobId: 'job',
        estimatedMassMg: 200000,
      );
      final second = await service.startAttempt(
        jobId: 'job',
        estimatedMassMg: 200000,
      );
      expect(first, isNot(second));
      final attempts = await database.select(database.printAttempts).get();
      expect(attempts.map((attempt) => attempt.sequence), containsAll([1, 2]));

      await service.logFailedPrint(
        jobId: 'job',
        materialProfileId: 'black',
        wastedMassMg: 100000,
        elapsedSeconds: 300,
        failureReason: 'Power loss',
      );
      final deduction = await (database.select(
        database.inventoryTransactions,
      )..where((row) => row.kind.equals('failed_print'))).getSingle();
      await service.reverseTransaction(
        transactionId: deduction.id,
        reason: 'Incorrect spool selected',
      );
      expect(
        (await database.select(database.inventoryTransactions).get()),
        hasLength(2),
      );
      expect(
        (await database.select(database.spools).get()).fold<int>(
          0,
          (sum, spool) => sum + spool.remainingMassMg,
        ),
        750000,
      );
    },
  );
}
