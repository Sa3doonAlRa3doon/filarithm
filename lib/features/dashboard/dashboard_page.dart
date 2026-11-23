import 'package:material_ui/material_ui.dart';

import '../../app/app_strings.dart';
import '../../core/database/app_database.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    required this.database,
    required this.onNavigate,
    super.key,
  });

  final AppDatabase database;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20,
          runSpacing: 20,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.text('comingReady'),
                  style: Theme.of(context).textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  strings.text('tagline'),
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: Colors.white70),
                ),
              ],
            ),
            FilledButton.icon(
              onPressed: () => onNavigate(1),
              icon: const Icon(Icons.add),
              label: Text(strings.text('newQuote')),
            ),
          ],
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth >= 900
                ? (constraints.maxWidth - 48) / 3
                : constraints.maxWidth;
            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                SizedBox(
                  width: width,
                  child: _CountCard(
                    title: strings.text('materials'),
                    icon: Icons.palette_outlined,
                    stream: database.watchMaterials(),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _CountCard(
                    title: strings.text('spools'),
                    icon: Icons.album_outlined,
                    stream: database.watchAvailableSpools(),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _CountCard(
                    title: strings.text('activeJobs'),
                    icon: Icons.precision_manufacturing_outlined,
                    stream: database.watchJobs(),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        Text(
          strings.text('quickStart'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _ActionCard(
              icon: Icons.upload_file,
              title: strings.text('importSlicer'),
              subtitle: '.gcode · .3mf · .gcode.3mf',
              onTap: () => onNavigate(1),
            ),
            _ActionCard(
              icon: Icons.document_scanner,
              title: strings.text('scanResult'),
              subtitle: 'ML Kit · Tesseract OCR',
              onTap: () => onNavigate(2),
            ),
            _ActionCard(
              icon: Icons.view_in_ar,
              title: strings.text('viewer'),
              subtitle: 'Transform · inspect · save',
              onTap: () => onNavigate(5),
            ),
          ],
        ),
      ],
    );
  }
}

class _CountCard<T> extends StatelessWidget {
  const _CountCard({
    required this.title,
    required this.icon,
    required this.stream,
  });

  final String title;
  final IconData icon;
  final Stream<List<T>> stream;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: StreamBuilder<List<T>>(
          stream: stream,
          builder: (context, snapshot) => Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(icon),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${snapshot.data?.length ?? 0}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(title, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 32,
                ),
                const SizedBox(height: 20),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(color: Colors.white60)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
