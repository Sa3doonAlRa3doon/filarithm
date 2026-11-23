import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import 'fifo_allocator.dart';

class InventoryService {
  const InventoryService(
    this.database, {
    this.allocator = const FifoSpoolAllocator(),
  });

  final AppDatabase database;
  final FifoSpoolAllocator allocator;

  Future<Map<String, AllocationPlan>> previewAllocation(
    Map<String, int> consumedMassMgByMaterial,
  ) async {
    final result = <String, AllocationPlan>{};
    for (final entry in consumedMassMgByMaterial.entries) {
      final rows =
          await (database.select(database.spools)..where(
                (row) =>
                    row.materialProfileId.equals(entry.key) &
                    row.archived.equals(false),
              ))
              .get();
      result[entry.key] = allocator.allocate(
        materialProfileId: entry.key,
        requestedMassMg: entry.value,
        spools: [
          for (final row in rows)
            SpoolStock(
              id: row.id,
              materialProfileId: row.materialProfileId,
              remainingMassMg: row.remainingMassMg,
              createdAt: row.createdAt,
              openedAt: row.openedAt,
            ),
        ],
      );
    }
    return result;
  }

  Future<void> completeJob({
    required String jobId,
    required Map<String, int> consumedMassMgByMaterial,
  }) async {
    await database.transaction(() async {
      final job = await (database.select(
        database.jobs,
      )..where((row) => row.id.equals(jobId))).getSingle();
      if (job.state == 'completed') {
        throw StateError('This job has already deducted inventory.');
      }
      final actualMassMg = consumedMassMgByMaterial.values.fold<int>(
        0,
        (sum, value) => sum + value,
      );
      final attemptId = const Uuid().v4();
      await database
          .into(database.printAttempts)
          .insert(
            PrintAttemptsCompanion.insert(
              id: attemptId,
              jobId: jobId,
              sequence: await _nextAttemptSequence(jobId),
              state: const Value('completed'),
              estimatedMassMg: Value(actualMassMg),
              actualMassMg: Value(actualMassMg),
              endedAt: Value(DateTime.now()),
            ),
          );
      for (final entry in consumedMassMgByMaterial.entries) {
        await _deduct(
          materialProfileId: entry.key,
          massMg: entry.value,
          jobId: jobId,
          attemptId: attemptId,
          kind: 'job_completion',
          note: 'Completed job filament deduction',
        );
      }
      await (database.update(
        database.jobs,
      )..where((row) => row.id.equals(jobId))).write(
        JobsCompanion(
          state: const Value('completed'),
          completedAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<void> logFailedPrint({
    required String jobId,
    required String materialProfileId,
    required int wastedMassMg,
    required int elapsedSeconds,
    required String failureReason,
    String? notes,
  }) async {
    if (elapsedSeconds < 0) {
      throw const FormatException('Elapsed time cannot be negative.');
    }
    if (failureReason.trim().isEmpty) {
      throw const FormatException('A failed print reason is required.');
    }
    await database.transaction(() async {
      final attemptId = const Uuid().v4();
      await database
          .into(database.printAttempts)
          .insert(
            PrintAttemptsCompanion.insert(
              id: attemptId,
              jobId: jobId,
              sequence: await _nextAttemptSequence(jobId),
              state: const Value('failed'),
              actualMassMg: Value(wastedMassMg),
              elapsedSeconds: Value(elapsedSeconds),
              failureReason: Value(failureReason.trim()),
              notes: Value(notes),
              endedAt: Value(DateTime.now()),
            ),
          );
      await _deduct(
        materialProfileId: materialProfileId,
        massMg: wastedMassMg,
        jobId: jobId,
        attemptId: attemptId,
        kind: 'failed_print',
        note: notes ?? failureReason,
      );
    });
  }

  Future<String> startAttempt({
    required String jobId,
    required int estimatedMassMg,
  }) async {
    if (estimatedMassMg < 0) {
      throw const FormatException('Estimated mass cannot be negative.');
    }
    final id = const Uuid().v4();
    await database.transaction(() async {
      await database
          .into(database.printAttempts)
          .insert(
            PrintAttemptsCompanion.insert(
              id: id,
              jobId: jobId,
              sequence: await _nextAttemptSequence(jobId),
              state: const Value('printing'),
              estimatedMassMg: Value(estimatedMassMg),
              startedAt: Value(DateTime.now()),
            ),
          );
      await (database.update(
        database.jobs,
      )..where((row) => row.id.equals(jobId))).write(
        JobsCompanion(
          state: const Value('printing'),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
    return id;
  }

  Future<void> cancelJob(String jobId) async {
    final job = await (database.select(
      database.jobs,
    )..where((row) => row.id.equals(jobId))).getSingle();
    if (job.state == 'completed') {
      throw StateError('A completed job must be reversed before cancellation.');
    }
    await (database.update(
      database.jobs,
    )..where((row) => row.id.equals(jobId))).write(
      JobsCompanion(
        state: const Value('canceled'),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> reverseTransaction({
    required String transactionId,
    required String reason,
  }) async {
    if (reason.trim().isEmpty) {
      throw const FormatException('A reversal reason is required.');
    }
    await database.transaction(() async {
      final original = await (database.select(
        database.inventoryTransactions,
      )..where((row) => row.id.equals(transactionId))).getSingle();
      final existing =
          await (database.select(database.inventoryTransactions)..where(
                (row) => row.reversalOfTransactionId.equals(transactionId),
              ))
              .get();
      if (existing.isNotEmpty) {
        throw StateError('This inventory transaction is already reversed.');
      }
      if (original.deltaMassMg >= 0) {
        throw StateError('Only a filament deduction can be reversed.');
      }
      final spool = await (database.select(
        database.spools,
      )..where((row) => row.id.equals(original.spoolId))).getSingle();
      await (database.update(
        database.spools,
      )..where((row) => row.id.equals(spool.id))).write(
        SpoolsCompanion(
          remainingMassMg: Value(spool.remainingMassMg - original.deltaMassMg),
        ),
      );
      await database
          .into(database.inventoryTransactions)
          .insert(
            InventoryTransactionsCompanion.insert(
              id: const Uuid().v4(),
              spoolId: original.spoolId,
              jobId: Value(original.jobId),
              attemptId: Value(original.attemptId),
              kind: 'reversal',
              deltaMassMg: -original.deltaMassMg,
              note: Value(reason.trim()),
              reversalOfTransactionId: Value(transactionId),
            ),
          );
    });
  }

  Future<void> _deduct({
    required String materialProfileId,
    required int massMg,
    required String jobId,
    String? attemptId,
    required String kind,
    required String note,
  }) async {
    if (massMg < 0) {
      throw const FormatException('Filament deduction cannot be negative.');
    }
    final rows =
        await (database.select(database.spools)..where(
              (row) =>
                  row.materialProfileId.equals(materialProfileId) &
                  row.archived.equals(false),
            ))
            .get();
    final plan = allocator.allocate(
      materialProfileId: materialProfileId,
      requestedMassMg: massMg,
      spools: rows
          .map(
            (row) => SpoolStock(
              id: row.id,
              materialProfileId: row.materialProfileId,
              remainingMassMg: row.remainingMassMg,
              createdAt: row.createdAt,
              openedAt: row.openedAt,
            ),
          )
          .toList(),
    );
    if (!plan.isFullyAllocated) {
      throw StateError(
        'Not enough matching filament: ${(plan.shortfallMassMg / 1000).toStringAsFixed(2)} g short.',
      );
    }
    for (final allocation in plan.allocations) {
      final spool = rows.firstWhere((row) => row.id == allocation.spoolId);
      await (database.update(
        database.spools,
      )..where((row) => row.id.equals(spool.id))).write(
        SpoolsCompanion(
          remainingMassMg: Value(spool.remainingMassMg - allocation.massMg),
        ),
      );
      await database
          .into(database.inventoryTransactions)
          .insert(
            InventoryTransactionsCompanion.insert(
              id: const Uuid().v4(),
              spoolId: spool.id,
              jobId: Value(jobId),
              attemptId: Value(attemptId),
              kind: kind,
              deltaMassMg: -allocation.massMg,
              note: Value(note),
            ),
          );
    }
  }

  Future<int> _nextAttemptSequence(String jobId) async {
    final attempts = await (database.select(
      database.printAttempts,
    )..where((row) => row.jobId.equals(jobId))).get();
    return attempts.fold<int>(
          0,
          (maximum, attempt) =>
              attempt.sequence > maximum ? attempt.sequence : maximum,
        ) +
        1;
  }
}
