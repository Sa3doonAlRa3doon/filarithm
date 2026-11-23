import 'package:material_ui/material_ui.dart';

import '../../app/app_strings.dart';
import '../../core/database/app_database.dart';
import '../calculator/calculator_page.dart';
import '../dashboard/dashboard_page.dart';
import '../inventory/inventory_page.dart';
import '../jobs/jobs_page.dart';
import '../scanner/scanner_page.dart';
import '../settings/settings_page.dart';
import '../viewer/viewer_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    required this.database,
    required this.onToggleLanguage,
    super.key,
  });

  final AppDatabase database;
  final VoidCallback onToggleLanguage;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final pages = [
      DashboardPage(database: widget.database, onNavigate: _navigate),
      CalculatorPage(database: widget.database),
      const ScannerPage(),
      InventoryPage(database: widget.database),
      JobsPage(database: widget.database),
      const ViewerPage(),
    ];
    final destinations = [
      _Destination(Icons.space_dashboard_outlined, 'dashboard'),
      _Destination(Icons.calculate_outlined, 'calculator'),
      _Destination(Icons.document_scanner_outlined, 'scanner'),
      _Destination(Icons.inventory_2_outlined, 'inventory'),
      _Destination(Icons.work_history_outlined, 'jobs'),
      _Destination(Icons.view_in_ar_outlined, 'viewer'),
    ];
    final wide = MediaQuery.sizeOf(context).width >= 840;
    final content = IndexedStack(index: _index, children: pages);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B57), Color(0xFF27D3C2)],
                ),
              ),
              child: const Icon(Icons.polyline_rounded, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(strings.text('appName')),
            if (wide) ...[
              const SizedBox(width: 10),
              Text(
                'by AVEONEX',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ],
        ),
        actions: [
          if (wide)
            const Chip(
              avatar: Icon(Icons.lock_outline, size: 16),
              label: Text('OFFLINE'),
            ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: widget.onToggleLanguage,
            icon: const Icon(Icons.language),
            label: Text(strings.text('language')),
          ),
          IconButton(
            tooltip: 'Settings & backup',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => SettingsPage(database: widget.database),
              ),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: wide
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _index,
                  onDestinationSelected: _navigate,
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (final item in destinations)
                      NavigationRailDestination(
                        icon: Icon(item.icon),
                        label: Text(strings.text(item.labelKey)),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: content),
              ],
            )
          : content,
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: _navigate,
              destinations: [
                for (final item in destinations)
                  NavigationDestination(
                    icon: Icon(item.icon),
                    label: strings.text(item.labelKey),
                  ),
              ],
            ),
    );
  }

  void _navigate(int index) => setState(() => _index = index);
}

class _Destination {
  const _Destination(this.icon, this.labelKey);

  final IconData icon;
  final String labelKey;
}
