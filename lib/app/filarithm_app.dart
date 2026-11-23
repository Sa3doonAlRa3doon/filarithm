import 'package:material_ui/material_ui.dart';

import '../core/database/app_database.dart';
import '../features/home/home_shell.dart';

class FilarithmApp extends StatefulWidget {
  const FilarithmApp({super.key});

  @override
  State<FilarithmApp> createState() => _FilarithmAppState();
}

class _FilarithmAppState extends State<FilarithmApp> {
  late final AppDatabase _database;
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF10192B);
    const ink = Color(0xFF0A1020);
    const coral = Color(0xFFFF6B57);
    const turquoise = Color(0xFF27D3C2);
    final scheme = ColorScheme.fromSeed(
      seedColor: coral,
      brightness: Brightness.dark,
      surface: navy,
    ).copyWith(primary: coral, secondary: turquoise);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filarithm by AVEONEX',
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: ink,
        fontFamily: _locale.languageCode == 'ar'
            ? 'IBMPlexSansArabic'
            : 'IBMPlexSans',
        cardTheme: const CardThemeData(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: Color(0xFF151F33),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF151F33),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: HomeShell(
        database: _database,
        onToggleLanguage: () => setState(() {
          _locale = Locale(_locale.languageCode == 'en' ? 'ar' : 'en');
        }),
      ),
    );
  }
}
