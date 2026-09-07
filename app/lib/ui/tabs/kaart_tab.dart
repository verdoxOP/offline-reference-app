import 'package:flutter/material.dart';

import '../../data/db.dart';
import '../../i18n/localization.dart';
import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import '../category_icons.dart';
import '../kaart/kaart_location.dart';
import '../kaart/kaart_map_screen.dart';
import '../widgets/dnp_spinner.dart';
import '../widgets/pressable.dart';
import '../widgets/topic_accordion_item.dart';

/// The Kaart tab: the wireframe's menu (view map / filter / my location /
/// download) leading into the interactive offline map, plus the existing
/// Kaart-category articles (noodsteunpunten, watertappunten, verzamelpunten)
/// as supplementary reading underneath.
class KaartTab extends StatefulWidget {
  const KaartTab({super.key, required this.db, required this.language});

  final AppDatabase db;
  final AppLanguage language;

  @override
  State<KaartTab> createState() => _KaartTabState();
}

class _KaartTabState extends State<KaartTab> with AutomaticKeepAliveClientMixin {
  late Future<List<Record>> _recordsFuture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _recordsFuture = _fetch();
  }

  @override
  void didUpdateWidget(covariant KaartTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.language != widget.language) {
      setState(() => _recordsFuture = _fetch());
    }
  }

  Future<List<Record>> _fetch() {
    return widget.db.filterRecords(
      '',
      language: widget.language.code,
      category: categoryLabelForKey(CategoryKey.kaart, widget.language),
    );
  }

  void _openMap({LocationType? filter}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => KaartMapScreen(language: widget.language, initialFilter: filter),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(DnpSpace.s4, DnpSpace.s3, DnpSpace.s4, DnpSpace.s8),
      children: [
        _MenuItem(
          icon: Icons.map_outlined,
          title: Strings.of(widget.language, 'viewOfflineMap'),
          subtitle: Strings.of(widget.language, 'viewOfflineMapDetail'),
          onTap: () => _openMap(),
        ),
        const SizedBox(height: DnpSpace.s2),
        _MenuItem(
          icon: Icons.filter_alt_outlined,
          title: Strings.of(widget.language, 'filterLocations'),
          subtitle: Strings.of(widget.language, 'filterLocationsDetail'),
          onTap: () => _openMap(filter: LocationType.noodsteun),
        ),
        const SizedBox(height: DnpSpace.s2),
        _MenuItem(
          icon: Icons.my_location,
          title: Strings.of(widget.language, 'myLocation'),
          subtitle: Strings.of(widget.language, 'myLocationDetail'),
          onTap: () => _openMap(),
        ),
        const SizedBox(height: DnpSpace.s2),
        _MenuItem(
          icon: Icons.download_done_outlined,
          title: Strings.of(widget.language, 'downloadMap'),
          subtitle: Strings.of(widget.language, 'downloadMapDetail'),
          trailing: Text(
            Strings.of(widget.language, 'downloadMapAlready'),
            style: DnpType.small.copyWith(color: DnpColors.accent),
          ),
          onTap: null,
        ),
        const SizedBox(height: DnpSpace.s6),
        Text(
          Strings.of(widget.language, 'information'),
          style: DnpType.label.copyWith(color: DnpColors.textMuted),
        ),
        const SizedBox(height: DnpSpace.s3),
        FutureBuilder<List<Record>>(
          future: _recordsFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: DnpSpace.s6),
                child: Center(child: DnpSpinner()),
              );
            }
            final records = snapshot.data!;
            return Column(
              children: [
                for (var i = 0; i < records.length; i++) ...[
                  if (i > 0) const SizedBox(height: DnpSpace.s2),
                  TopicAccordionItem(record: records[i], language: widget.language),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      semanticLabel: title,
      scaleOnPress: false,
      builder: (context, hovered, pressed) => Container(
        padding: const EdgeInsets.all(DnpSpace.s4),
        decoration: BoxDecoration(
          color: hovered && onTap != null ? DnpColors.surface3 : DnpColors.surface2,
          border: Border.all(color: DnpColors.borderSubtle),
          borderRadius: BorderRadius.circular(DnpRadius.md),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: DnpColors.catKaartQuiet,
                borderRadius: BorderRadius.circular(DnpRadius.sm),
              ),
              child: Icon(icon, size: 20, color: DnpColors.catKaart),
            ),
            const SizedBox(width: DnpSpace.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: DnpType.listItemTitle.copyWith(color: DnpColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: DnpType.small.copyWith(color: DnpColors.textSecondary),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (onTap != null)
              const Icon(Icons.chevron_right, size: 20, color: DnpColors.textMuted),
          ],
        ),
      ),
    );
  }
}
