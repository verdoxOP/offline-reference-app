import 'package:flutter/material.dart';
import '../data/db.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.db});

  final AppDatabase db;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Record>> _recordsFuture;

  @override
  void initState() {
    super.initState();
    _recordsFuture = widget.db.getAllRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Reference')),
      body: FutureBuilder<List<Record>>(
        future: _recordsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final records = snapshot.data!;
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, i) {
              final r = records[i];
              return ListTile(
                title: Text(r.title ?? 'No title'),
                subtitle: Text(r.category ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
