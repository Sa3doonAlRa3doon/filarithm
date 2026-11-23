import 'package:drift/drift.dart' show Value;
import 'package:material_ui/material_ui.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({required this.database, super.key});

  final AppDatabase database;

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: TabBar(
        controller: _tabs,
        tabs: const [
          Tab(text: 'Material profiles'),
          Tab(text: 'Physical spools'),
        ],
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _MaterialList(database: widget.database),
          _SpoolList(database: widget.database),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _tabs.index == 0
            ? _showMaterialDialog(context)
            : _showSpoolDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }

  Future<void> _showMaterialDialog(BuildContext context) async {
    final name = TextEditingController();
    final type = TextEditingController();
    final brand = TextEditingController();
    final color = TextEditingController();
    final price = TextEditingController();
    final weight = TextEditingController();
    final density = TextEditingController();
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add material profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Name (e.g. Pink PLA)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: type,
                decoration: const InputDecoration(labelText: 'Material type'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: brand,
                decoration: const InputDecoration(
                  labelText: 'Brand (optional)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: color,
                decoration: const InputDecoration(labelText: 'Hex colour'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: price,
                decoration: const InputDecoration(
                  labelText: 'Spool price',
                  suffixText: 'AED',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: weight,
                decoration: const InputDecoration(
                  labelText: 'Nominal weight',
                  suffixText: 'g',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: density,
                decoration: const InputDecoration(
                  labelText: 'Material density',
                  suffixText: 'g/cm³',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (accepted == true) {
      final priceValue = double.tryParse(price.text.trim());
      final weightValue = double.tryParse(weight.text.trim());
      final densityValue = double.tryParse(density.text.trim());
      final colorValue = color.text.trim().toUpperCase();
      if (name.text.trim().isEmpty ||
          type.text.trim().isEmpty ||
          priceValue == null ||
          priceValue < 0 ||
          weightValue == null ||
          weightValue <= 0 ||
          densityValue == null ||
          densityValue <= 0 ||
          !RegExp(r'^#[0-9A-F]{6}$').hasMatch(colorValue)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Enter a name, type, #RRGGBB color, non-negative price, positive weight and density.',
              ),
            ),
          );
        }
        return;
      }
      await widget.database
          .into(widget.database.materialProfiles)
          .insert(
            MaterialProfilesCompanion.insert(
              id: const Uuid().v4(),
              name: name.text.trim(),
              materialType: type.text.trim(),
              brand: Value(
                brand.text.trim().isEmpty ? null : brand.text.trim(),
              ),
              colorHex: colorValue,
              spoolPriceMicros: (priceValue * 1000000).round(),
              nominalMassMg: (weightValue * 1000).round(),
              densityMicrogramsPerCubicMillimeter: Value(
                (densityValue * 1000).round(),
              ),
            ),
          );
    }
  }

  Future<void> _showSpoolDialog(BuildContext context) async {
    final materials = await widget.database
        .select(widget.database.materialProfiles)
        .get();
    if (!context.mounted) return;
    if (materials.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add a material profile first.')),
      );
      return;
    }
    var selected = materials.first.id;
    final remaining = TextEditingController();
    final lot = TextEditingController();
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add physical spool'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: selected,
                decoration: const InputDecoration(labelText: 'Material'),
                items: materials
                    .map(
                      (item) => DropdownMenuItem(
                        value: item.id,
                        child: Text(item.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setDialogState(() => selected = value ?? selected),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: remaining,
                decoration: const InputDecoration(
                  labelText: 'Remaining',
                  suffixText: 'g',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: lot,
                decoration: const InputDecoration(
                  labelText: 'Lot / label (optional)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (accepted == true) {
      final remainingValue = double.tryParse(remaining.text.trim());
      if (remainingValue == null || remainingValue < 0) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Enter a non-negative remaining mass.'),
            ),
          );
        }
        return;
      }
      await widget.database
          .into(widget.database.spools)
          .insert(
            SpoolsCompanion.insert(
              id: const Uuid().v4(),
              materialProfileId: selected,
              lotCode: Value(lot.text.trim().isEmpty ? null : lot.text.trim()),
              remainingMassMg: (remainingValue * 1000).round(),
              openedAt: Value(DateTime.now()),
            ),
          );
    }
  }
}

class _MaterialList extends StatelessWidget {
  const _MaterialList({required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MaterialProfile>>(
      stream: database.watchMaterials(),
      builder: (context, snapshot) {
        final rows = snapshot.data ?? const [];
        if (rows.isEmpty) {
          return const _EmptyInventory(
            message: 'Add unlimited colours and material profiles.',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: rows.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final row = rows[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _parseColor(row.colorHex),
                ),
                title: Text(row.name),
                subtitle: Text(
                  '${row.materialType} · ${(row.nominalMassMg / 1000).toStringAsFixed(0)} g',
                ),
                trailing: Text(
                  '${(row.spoolPriceMicros / 1000000).toStringAsFixed(2)} AED',
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SpoolList extends StatelessWidget {
  const _SpoolList({required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Spool>>(
      stream: database.watchAvailableSpools(),
      builder: (context, snapshot) {
        final rows = snapshot.data ?? const [];
        if (rows.isEmpty) {
          return const _EmptyInventory(
            message: 'Track each physical spool and its remaining stock.',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: rows.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final row = rows[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.album_outlined),
                title: Text(
                  '${(row.remainingMassMg / 1000).toStringAsFixed(1)} g remaining',
                ),
                subtitle: Text(row.lotCode ?? row.materialProfileId),
                trailing: IconButton(
                  tooltip: 'Archive spool',
                  icon: const Icon(Icons.archive_outlined),
                  onPressed: () =>
                      (database.update(database.spools)
                            ..where((item) => item.id.equals(row.id)))
                          .write(const SpoolsCompanion(archived: Value(true))),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _EmptyInventory extends StatelessWidget {
  const _EmptyInventory({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.inventory_2_outlined, size: 56, color: Colors.white30),
        const SizedBox(height: 12),
        Text(message),
      ],
    ),
  );
}

Color _parseColor(String value) {
  final cleaned = value.replaceFirst('#', '');
  final number = int.tryParse(cleaned, radix: 16) ?? 0x888888;
  return Color(0xFF000000 | number);
}
