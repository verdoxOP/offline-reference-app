import 'package:flutter/material.dart';

import 'data/db.dart';
import 'data/user_db.dart';
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

/// Shows the splash screen while the pre-packaged Isar dataset opens,
/// together with the local user database.
class _Launcher extends StatefulWidget {
  const _Launcher();

  @override
  State<_Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<_Launcher> {
  late final Future<({AppDatabase appDb, UserDatabase userDb})> _dbFuture;

  final _language = AppLanguageController(
    AppLanguage.nl,
  );

  @override
  void initState() {
    super.initState();

    _dbFuture = _openDatabases();
  }

  Future<({AppDatabase appDb, UserDatabase userDb})>
  _openDatabases() async {
    debugPrint('Opening AppDatabase...');

    final appDb = await AppDatabase.open();

    debugPrint('AppDatabase opened');

    debugPrint('Opening UserDatabase...');

    final userDb = await UserDatabase.open();

    debugPrint('UserDatabase opened');

    await Future.delayed(
      const Duration(milliseconds: 900),
    );

    debugPrint('Databases ready');

    return (
    appDb: appDb,
    userDb: userDb,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<
        ({
        AppDatabase appDb,
        UserDatabase userDb,
        })>(
      future: _dbFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Text(
                    'Database startup error:\n\n'
                        '${snapshot.error}\n\n'
                        '${snapshot.stackTrace}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const SplashScreen();
        }

        return AppShell(
          db: snapshot.data!.appDb,
          userDb: snapshot.data!.userDb,
          language: _language,
        );
      },
    );
  }
}