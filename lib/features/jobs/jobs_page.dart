import 'package:drift/drift.dart' show Value;
import 'package:material_ui/material_ui.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';
import '../../core/inventory/inventory_service.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({required this.database, super.key});

  final AppDatabase database;

  InventoryService get _inventory => InventoryService(database);

  static const states = [
    'draft',
    'quoted',
    'approved',
    'printing',
    'completed',
    'canceled',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<List<Job>>(
        stream: database.watchJobs(),
        builder: (context, snapshot) {
          final jobs = snapshot.data ?? const [];
          if (jobs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.work_history_outlined,
                    size: 56,
                    color: Colors.white30,
                  ),
                  SizedBox(height: 12),
                  Text('Jobs will move from quote to completed here.'),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: jobs.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final job = jobs[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(child: Text('${index + 1}')),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.sourceName ?? 'Manual job',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              job.id,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      DropdownButton<String>(
                        value: job.state,
                        items: states
                            .map(
                              (state) => DropdownMenuItem(
                                value: state,
                                child: Text(state),
                              ),
                            )
                            .toList(),
                        onChanged: (state) async {
                          if (state == null) return;
                          if (state == 'completed') {
                            await _completeJob(context, job);
                          } else if (state == 'canceled') {
                            await _run(
                              context,
                              () => _inventory.cancelJob(job.id),
                              'Job canceled without deducting stock.',
                            );
                          } else {
                            await (database.update(
                              database.jobs,
                            )..where((row) => row.id.equals(job.id))).write(
                              JobsCompanion(
                                state: Value(state),
                                updatedAt: Value(DateTime.now()),
                              ),
                            );
                          }
                        },
                      ),
                      PopupMenuButton<String>(
                        tooltip: 'Print attempts and waste',
                        onSelected: (action) async {
                          if (action == 'failed') {
                            await _logFailedPrint(context, job);
                          } else if (action == 'reprint') {
                            await _startAttempt(context, job);
                          }
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: 'reprint',
                            child: Text('Start print / reprint'),
                          ),
                          PopupMenuItem(
                            value: 'failed',
                            child: Text('Log failed print'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => database
            .into(database.jobs)
            .insert(
              JobsCompanion.insert(
                id: const Uuid().v4(),
                sourceName: const Value('New workshop job'),
                projectJson: '{}',
              ),
            ),
        icon: const Icon(Icons.add),
        label: const Text('New job'),
      ),
    );
  }

  Future<void> _completeJob(BuildContext context, Job job) async {
    final materials = await database.select(database.materialProfiles).get();
    if (!context.mounted) return;
    if (materials.isEmpty) {
      _message(context, 'Add material profiles and spools before completion.');
      return;
    }
    final controllers = {
      for (final material in materials) material.id: TextEditingController(),
    };
    final accepted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm actual filament used'),
        content: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter actual grams when known. Leave unused materials blank. FIFO allocation will be shown in the ledger and cannot make stock negative.',
                ),
                const SizedBox(height: 12),
                for (final material in materials)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: controllers[material.id],
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: material.name,
                        suffixText: 'g',
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Confirm & deduct'),
          ),
        ],
      ),
    );
    final consumption = <String, int>{};
    for (final entry in controllers.entries) {
      final grams = double.tryParse(entry.value.text.trim());
      if (grams != null && grams > 0) {
        consumption[entry.key] = (grams * 1000).round();
      }
      entry.value.dispose();
    }
    if (accepted != true || !context.mounted) return;
    if (consumption.isEmpty) {
      _message(context, 'Enter at least one positive material amount.');
      return;
    }
    final plans = await _inventory.previewAllocation(consumption);
    if (!context.mounted) return;
    final shortfall = plans.values.where((plan) => !plan.isFullyAllocated);
    if (shortfall.isNotEmpty) {
      _message(
        context,
        'Insufficient stock: ${(shortfall.first.shortfallMassMg / 1000).toStringAsFixed(2)} g short.',
      );
      return;
    }
    final allocationConfirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm FIFO spool allocation'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final entry in plans.entries) ...[
                Text(
                  materials.firstWhere((row) => row.id == entry.key).name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                for (final allocation in entry.value.allocations)
                  Text(
                    '${(allocation.massMg / 1000).toStringAsFixed(2)} g from spool ${allocation.spoolId}',
                  ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Confirm deduction'),
          ),
        ],
      ),
    );
    if (allocationConfirmed != true || !context.mounted) return;
    await _run(
      context,
      () => _inventory.completeJob(
        jobId: job.id,
        consumedMassMgByMaterial: consumption,
      ),
      'Job completed and FIFO stock deducted.',
    );
  }

  Future<void> _startAttempt(BuildContext context, Job job) async {
    final grams = TextEditingController();
    final accepted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Start print / reprint'),
        content: TextField(
          controller: grams,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Estimated total filament',
            suffixText: 'g',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Start attempt'),
          ),
        ],
      ),
    );
    final value = double.tryParse(grams.text.trim());
    grams.dispose();
    if (accepted != true || value == null || value < 0 || !context.mounted) {
      return;
    }
    await _run(
      context,
      () => _inventory.startAttempt(
        jobId: job.id,
        estimatedMassMg: (value * 1000).round(),
      ),
      'Print attempt started.',
    );
  }

  Future<void> _logFailedPrint(BuildContext context, Job job) async {
    final materials = await database.select(database.materialProfiles).get();
    if (!context.mounted || materials.isEmpty) {
      if (context.mounted) _message(context, 'Add a material profile first.');
      return;
    }
    var materialId = materials.first.id;
    final grams = TextEditingController();
    final minutes = TextEditingController();
    final reason = TextEditingController();
    final notes = TextEditingController();
    final accepted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, update) => AlertDialog(
          title: const Text('Log failed print waste'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: materialId,
                  decoration: const InputDecoration(labelText: 'Material'),
                  items: [
                    for (final material in materials)
                      DropdownMenuItem(
                        value: material.id,
                        child: Text(material.name),
                      ),
                  ],
                  onChanged: (value) =>
                      update(() => materialId = value ?? materialId),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: grams,
                  decoration: const InputDecoration(
                    labelText: 'Wasted filament',
                    suffixText: 'g',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: minutes,
                  decoration: const InputDecoration(
                    labelText: 'Elapsed print time',
                    suffixText: 'minutes',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: reason,
                  decoration: const InputDecoration(labelText: 'Reason'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: notes,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Deduct waste'),
            ),
          ],
        ),
      ),
    );
    final gramValue = double.tryParse(grams.text.trim());
    final minuteValue = double.tryParse(minutes.text.trim());
    final reasonValue = reason.text.trim();
    final notesValue = notes.text.trim();
    for (final controller in [grams, minutes, reason, notes]) {
      controller.dispose();
    }
    if (accepted != true || !context.mounted) return;
    if (gramValue == null ||
        gramValue < 0 ||
        minuteValue == null ||
        minuteValue < 0 ||
        reasonValue.isEmpty) {
      _message(context, 'Enter valid waste, elapsed time and a reason.');
      return;
    }
    await _run(
      context,
      () => _inventory.logFailedPrint(
        jobId: job.id,
        materialProfileId: materialId,
        wastedMassMg: (gramValue * 1000).round(),
        elapsedSeconds: (minuteValue * 60).round(),
        failureReason: reasonValue,
        notes: notesValue.isEmpty ? null : notesValue,
      ),
      'Failed-print waste deducted; customer job remains open.',
    );
  }

  Future<void> _run(
    BuildContext context,
    Future<Object?> Function() action,
    String success,
  ) async {
    try {
      await action();
      if (context.mounted) _message(context, success);
    } catch (error) {
      if (context.mounted) _message(context, 'Action failed: $error');
    }
  }

  void _message(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
