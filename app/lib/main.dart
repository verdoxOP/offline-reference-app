import 'package:flutter/material.dart';
import 'data/db.dart';
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
      title: 'Offline Reference',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(db: db),
    );
  }
}
