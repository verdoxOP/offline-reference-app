import 'package:flutter/material.dart';

import '../data/db.dart';
import '../i18n/localization.dart';
import '../theme/dnp_colors.dart';
import '../theme/dnp_spacing.dart';
import '../theme/dnp_typography.dart';
import 'category_icons.dart';
import 'credits_screen.dart';
import 'record_detail.dart';
import 'widgets/category_tabs.dart';
import 'widgets/dnp_app_bar.dart';
import 'widgets/empty_state.dart';
import 'widgets/language_toggle.dart';
import 'widgets/offline_notice.dart';
import 'widgets/pressable.dart';
import 'widgets/record_list_item.dart';
import 'widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.db, required this.language});

  final AppDatabase db;
  final AppLanguageController language;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  CategoryKey? _category;
  late Future<List<Record>> _rowsFuture;
  late Future<Map<CategoryKey?, int>> _countsFuture;

  @override
  void initState() {
    super.initState();
    widget.language.addListener(_onLanguageChanged);
    _rowsFuture = _fetchRows();
    _countsFuture = _fetchCounts();
  }

  @override
  void dispose() {
    widget.language.removeListener(_onLanguageChanged);
    _searchController.dispose();
    super.dispose();
  }

  AppLanguage get _lang => widget.language.value;

  void _onLanguageChanged() {
    setState(() {
      _rowsFuture = _fetchRows();
      _countsFuture = _fetchCounts();
    });
  }

  void _onSearchChanged(String value) {
    setState(() => _rowsFuture = _fetchRows());
  }

  void _onCategoryChanged(CategoryKey? key) {
    setState(() {
      _category = key;
      _rowsFuture = _fetchRows();
    });
  }

  Future<List<Record>> _fetchRows() {
    return widget.db.filterRecords(
      _searchController.text,
      language: _lang.code,
      category: _category == null ? null : categoryLabelForKey(_category!, _lang),
    );
  }

  Future<Map<CategoryKey?, int>> _fetchCounts() async {
    final keys = <CategoryKey?>[null, ...CategoryKey.values];
    final counts = await Future.wait(keys.map(
      (key) => widget.db.countRecords(
        language: _lang.code,
        category: key == null ? null : categoryLabelForKey(key, _lang),
      ),
    ));
    return Map.fromIterables(keys, counts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DnpColors.surface1,
      appBar: DnpAppBar(
        title: Strings.of(_lang, 'appTitle'),
        language: _lang,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Pressable(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => CreditsScreen(language: _lang)),
              ),
              semanticLabel: Strings.of(_lang, 'credits'),
              scaleOnPress: false,
              builder: (context, hovered, pressed) => Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hovered ? DnpColors.surface3 : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.info_outline, size: 20, color: DnpColors.textSecondary),
              ),
            ),
            const SizedBox(width: DnpSpace.s2),
            LanguageToggle(value: _lang, onChanged: (v) => widget.language.value = v),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              DnpSpace.s4,
              DnpSpace.s4,
              DnpSpace.s4,
              DnpSpace.s3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DNP', style: DnpType.brandWordmark.copyWith(color: DnpColors.textPrimary)),
                Text(
                  Strings.of(_lang, 'brandLine'),
                  style: DnpType.brandLine.copyWith(color: DnpColors.accent),
                ),
                const SizedBox(height: DnpSpace.s3),
                DnpSearchField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  placeholder: Strings.of(_lang, 'searchHint'),
                  clearLabel: Strings.of(_lang, 'clear'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: DnpSpace.s3),
            child: FutureBuilder<Map<CategoryKey?, int>>(
              future: _countsFuture,
              builder: (context, snapshot) {
                final counts = snapshot.data;
                return CategoryTabs(
                  value: _category,
                  onChanged: _onCategoryChanged,
                  items: [
                    CategoryTabItem(
                      key: null,
                      label: Strings.of(_lang, 'all'),
                      count: counts?[null],
                    ),
                    for (final key in CategoryKey.values)
                      CategoryTabItem(
                        key: key,
                        label: categoryLabelForKey(key, _lang),
                        count: counts?[key],
                      ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Record>>(
              future: _rowsFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: DnpColors.accent),
                  );
                }
                final records = snapshot.data!;
                final showOfflineNotice = _searchController.text.isEmpty && _category == null;
                return ListView(
                  padding: const EdgeInsets.fromLTRB(
                    DnpSpace.s4,
                    0,
                    DnpSpace.s4,
                    DnpSpace.s8,
                  ),
                  children: [
                    if (showOfflineNotice) ...[
                      OfflineNotice(
                        label: Strings.of(_lang, 'offline'),
                        detail: Strings.of(_lang, 'offlineDetail'),
                      ),
                      const SizedBox(height: DnpSpace.s2),
                    ],
                    if (records.isEmpty)
                      EmptyState(
                        title: Strings.of(_lang, 'noResults'),
                        description: Strings.of(_lang, 'emptyHint'),
                      )
                    else
                      for (final record in records) ...[
                        RecordListItem(
                          title: record.title ?? '',
                          category: record.category ?? '',
                          thumbnail: record.imageUrls?.isNotEmpty == true
                              ? record.imageUrls!.first
                              : null,
                          compressed: true,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RecordDetailScreen(record: record, language: _lang),
                            ),
                          ),
                        ),
                        const SizedBox(height: DnpSpace.s2),
                      ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
