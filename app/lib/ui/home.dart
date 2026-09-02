import 'package:flutter/material.dart';
import '../data/db.dart';
import 'record_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.db});

  final AppDatabase db;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Record>> _recordsFuture;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recordsFuture = widget.db.getAllRecords();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _recordsFuture = widget.db.searchRecords(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Reference')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search title or category',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Record>>(
              future: _recordsFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final records = snapshot.data!;
                if (records.isEmpty) {
                  return const Center(child: Text('No matching records'));
                }
                return ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, i) {
                    final r = records[i];
                    return ListTile(
                      title: Text(r.title ?? 'No title'),
                      subtitle: Text(r.category ?? ''),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RecordDetailScreen(record: r)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
