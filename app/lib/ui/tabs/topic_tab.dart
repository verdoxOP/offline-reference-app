import 'package:flutter/material.dart';

import '../../data/db.dart';
import '../../i18n/localization.dart';
import '../../theme/dnp_spacing.dart';
import '../category_icons.dart';
import '../widgets/dnp_spinner.dart';
import '../widgets/empty_state.dart';
import '../widgets/topic_accordion_item.dart';

/// One tab's content: every record in [category], each row a collapsible
/// [TopicAccordionItem]. Used for Basis, Nood and FAQ — the three tabs whose
/// wireframe content is a flat accordion list.
class TopicTab extends StatefulWidget {
  const TopicTab({
    super.key,
    required this.db,
    required this.language,
    required this.category,
  });

  final AppDatabase db;
  final AppLanguage language;
  final CategoryKey category;

  @override
  State<TopicTab> createState() => _TopicTabState();
}

class _TopicTabState extends State<TopicTab> with AutomaticKeepAliveClientMixin {
  late Future<List<Record>> _recordsFuture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _recordsFuture = _fetch();
  }

  @override
  void didUpdateWidget(covariant TopicTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.language != widget.language) {
      setState(() => _recordsFuture = _fetch());
    }
  }

  Future<List<Record>> _fetch() {
    return widget.db.filterRecords(
      '',
      language: widget.language.code,
      category: categoryLabelForKey(widget.category, widget.language),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Record>>(
      future: _recordsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: DnpSpinner());
        }
        final records = snapshot.data!;
        if (records.isEmpty) {
          return Center(
            child: EmptyState(
              title: Strings.of(widget.language, 'noResults'),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(DnpSpace.s4, DnpSpace.s3, DnpSpace.s4, DnpSpace.s8),
          itemCount: records.length,
          separatorBuilder: (_, __) => const SizedBox(height: DnpSpace.s2),
          itemBuilder: (context, i) => TopicAccordionItem(
            record: records[i],
            language: widget.language,
          ),
        );
      },
    );
  }
}
