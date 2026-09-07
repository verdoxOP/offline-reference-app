import 'package:flutter/material.dart';
import 'data/db.dart';
import 'i18n/localization.dart';
import 'theme/dnp_theme.dart';
import 'ui/app_shell.dart';
import 'ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DNP — MijnNoodpakket',
      debugShowCheckedModeBanner: false,
      theme: DnpTheme.build(),
      home: const _Launcher(),
    );
  }
}

/// Shows the splash screen while the pre-packaged Isar dataset opens (a
/// bundled-asset copy on first launch, otherwise a local file — see
/// AppDatabase.open), then hands off to the main tab shell.
class _Launcher extends StatefulWidget {
  const _Launcher();

  @override
  State<_Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<_Launcher> {
  late final Future<AppDatabase> _dbFuture;
  final _language = AppLanguageController(AppLanguage.nl);

  @override
  void initState() {
    super.initState();
    _dbFuture = Future.wait([
      AppDatabase.open(),
      Future.delayed(const Duration(milliseconds: 900)),
    ]).then((results) => results.first as AppDatabase);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDatabase>(
      future: _dbFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SplashScreen();
        return AppShell(db: snapshot.data!, language: _language);
      },
    );
  }
}
