import 'package:flutter/material.dart';
import '../data/db.dart';
import '../i18n/localization.dart';
import 'category_icons.dart';
import 'record_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.db, required this.language});

  final AppDatabase db;
  final AppLanguageController language;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Record>> _recordsFuture;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.language.addListener(_onLanguageChanged);
    _recordsFuture = widget.db.getAllRecords(language: widget.language.value.code);
  }

  @override
  void dispose() {
    widget.language.removeListener(_onLanguageChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onLanguageChanged() => _runSearch(_searchController.text);

  void _onSearchChanged(String query) => _runSearch(query);

  void _runSearch(String query) {
    setState(() {
      _recordsFuture = widget.db.searchRecords(query, language: widget.language.value.code);
    });
  }

  void _toggleLanguage() {
    widget.language.value = widget.language.value.other;
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.language.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(lang, 'appTitle')),
        actions: [
          TextButton(
            onPressed: _toggleLanguage,
            child: Text(
              lang == AppLanguage.nl ? 'NL' : 'EN',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: Strings.of(lang, 'searchHint'),
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
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
                  return Center(child: Text(Strings.of(lang, 'noResults')));
                }
                return ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, i) {
                    final r = records[i];
                    return ListTile(
                      leading: Icon(iconForCategory(r.category)),
                      title: Text(r.title ?? 'No title'),
                      subtitle: Text(r.category ?? ''),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RecordDetailScreen(record: r, language: lang),
                        ),
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
