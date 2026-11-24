import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:filarithm/core/database/app_database.dart';
import 'package:filarithm/features/calculator/calculator_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const shareProbeSeconds = int.fromEnvironment(
    'FILARITHM_SHARE_PROBE_SECONDS',
    defaultValue: 2,
  );

  testWidgets(
    'creates an immutable quote and launches the Android PDF share flow',
    (tester) async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(useMaterial3: true),
          home: Scaffold(body: CalculatorPage(database: database)),
        ),
      );
      await tester.pumpAndSettle();

      await _enter(tester, 'Total filament', '30');
      await _enter(tester, 'Print time', '2');
      await _enter(tester, 'Spool price', '100');
      await _enter(tester, 'Electricity', '0.40');
      await _enter(tester, 'Machine rate', '8');
      await _enter(tester, 'Labour rate', '25');
      await _enter(tester, 'Printer power', '300');
      await _enter(tester, 'Failure allowance', '10');
      await _enter(tester, 'Marketplace fee', '3');
      await _enter(tester, 'Fixed platform fee', '2');
      await _enter(tester, 'Setup labour', '10');
      await _enter(tester, 'Labour per plate run', '5');
      await _enter(tester, 'Finishing per unit', '2');
      await _enter(tester, 'Order packaging', '4');
      await _enter(tester, 'Shipping', '0');
      await _enter(tester, 'Customer name', 'Integration Customer');
      await _enter(tester, 'Turnaround date or lead time', '3 working days');

      await _tapVisible(tester, find.text('Recalculate'));
      expect(find.textContaining('AED'), findsWidgets);

      await _tapVisible(tester, find.text('Save quote & job'));
      await tester.pumpAndSettle();

      final quotes = await database.select(database.quotes).get();
      final revisions = await database.select(database.quoteRevisions).get();
      final jobs = await database.select(database.jobs).get();
      expect(quotes, hasLength(1));
      expect(revisions, hasLength(1));
      expect(jobs, hasLength(1));
      expect(quotes.single.quoteNumber, matches(r'^AVX-\d{4}-0001$'));
      expect(revisions.single.snapshotJson, quotes.single.snapshotJson);
      expect(quotes.single.totalMicros, greaterThan(0));

      await _tapVisible(tester, find.text('Share PDF / WhatsApp'));
      await tester.pump(const Duration(seconds: 2));

      // A longer probe delay can be supplied locally so an external ADB
      // assertion can verify that Android received the production share intent.
      await Future<void>.delayed(Duration(seconds: shareProbeSeconds));
    },
    skip: !Platform.isAndroid,
  );
}

Finder _field(String label) => find.byWidgetPredicate(
  (widget) => widget is TextField && widget.decoration?.labelText == label,
  description: 'TextField labelled "$label"',
);

Future<void> _enter(WidgetTester tester, String label, String value) async {
  final finder = _field(label);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, value);
  await tester.pump();
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pump();
}
