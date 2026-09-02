import 'package:flutter/material.dart';
import 'data/db.dart';
import 'i18n/localization.dart';
import 'theme/dnp_theme.dart';
import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await AppDatabase.open();
  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.db});

  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DNP — Digitaal Noodpakket',
      debugShowCheckedModeBanner: false,
      theme: DnpTheme.build(),
      home: HomeScreen(db: db, language: AppLanguageController(AppLanguage.nl)),
    );
  }
}
