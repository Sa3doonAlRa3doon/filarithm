import 'package:filarithm/app/app_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('English labels render left-to-right', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: Builder(
          builder: (context) => Text(AppStrings.of(context).text('newQuote')),
        ),
      ),
    );

    final context = tester.element(find.text('New quote'));
    expect(Directionality.of(context), TextDirection.ltr);
  });

  testWidgets('Arabic labels render right-to-left', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: Builder(
          builder: (context) => Text(AppStrings.of(context).text('newQuote')),
        ),
      ),
    );

    final context = tester.element(find.text('عرض سعر جديد'));
    expect(Directionality.of(context), TextDirection.rtl);
  });
}
