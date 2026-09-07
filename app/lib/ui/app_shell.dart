import 'package:flutter/material.dart';

import '../data/db.dart';
import '../i18n/localization.dart';
import '../theme/dnp_colors.dart';
import '../theme/dnp_motion.dart';
import '../theme/dnp_spacing.dart';
import '../theme/dnp_typography.dart';
import 'category_icons.dart';
import 'credits_screen.dart';
import 'tabs/kaart_tab.dart';
import 'tabs/topic_tab.dart';
import 'widgets/dnp_app_bar.dart';
import 'widgets/language_toggle.dart';
import 'widgets/pressable.dart';
import 'widgets/status_banner.dart';

/// The app's main screen: the wireframe's "Overzicht" — a status banner over
/// a Basis/Nood/Kaart/FAQ tab strip, replacing the old single searchable
/// list. Owns the four tabs' `TabController` so switching tabs never
/// rebuilds the others (each tab keeps its own fetched records alive via
/// `AutomaticKeepAliveClientMixin`).
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.db, required this.language});

  final AppDatabase db;
  final AppLanguageController language;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: CategoryKey.values.length, vsync: this);
    widget.language.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    widget.language.removeListener(_onLanguageChanged);
    _tabController.dispose();
    super.dispose();
  }

  AppLanguage get _lang => widget.language.value;

  void _onLanguageChanged() => setState(() {});

  void _openSettings() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: DnpColors.surface2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(DnpRadius.lg)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DnpSpace.s4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.of(_lang, 'settings'),
                style: DnpType.heading.copyWith(color: DnpColors.textPrimary),
              ),
              const SizedBox(height: DnpSpace.s4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.of(_lang, 'language'),
                    style: DnpType.body.copyWith(color: DnpColors.textBody),
                  ),
                  LanguageToggle(value: _lang, onChanged: (v) => widget.language.value = v),
                ],
              ),
              const SizedBox(height: DnpSpace.s2),
              Pressable(
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => CreditsScreen(language: _lang)),
                  );
                },
                semanticLabel: Strings.of(_lang, 'credits'),
                scaleOnPress: false,
                builder: (context, hovered, pressed) => Container(
                  padding: const EdgeInsets.symmetric(vertical: DnpSpace.s3),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, size: 20, color: DnpColors.textSecondary),
                      const SizedBox(width: DnpSpace.s3),
                      Text(
                        Strings.of(_lang, 'credits'),
                        style: DnpType.body.copyWith(color: DnpColors.textBody),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DnpColors.surface1,
      appBar: DnpAppBar(
        title: Strings.of(_lang, 'overview'),
        language: _lang,
        trailing: Pressable(
          onTap: _openSettings,
          semanticLabel: Strings.of(_lang, 'settings'),
          scaleOnPress: false,
          builder: (context, hovered, pressed) => Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: hovered ? DnpColors.surface3 : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.settings_outlined, size: 20, color: DnpColors.textSecondary),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(DnpSpace.s4, DnpSpace.s3, DnpSpace.s4, DnpSpace.s3),
            child: StatusBanner(
              label: Strings.of(_lang, 'statusOk'),
              emphasis: Strings.of(_lang, 'statusOkEmphasis'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4),
            child: _TopTabBar(controller: _tabController, language: _lang),
          ),
          const SizedBox(height: DnpSpace.s2),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                for (final key in CategoryKey.values)
                  key == CategoryKey.kaart
                      ? KaartTab(db: widget.db, language: _lang)
                      : TopicTab(db: widget.db, language: _lang, category: key),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-width four-segment tab strip (Basis/Nood/Kaart/FAQ), the wireframe's
/// pill row under the status banner — a fixed set of equal-width
/// destinations bound to a [TabController].
class _TopTabBar extends StatelessWidget {
  const _TopTabBar({required this.controller, required this.language});

  final TabController controller;
  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: DnpColors.surface2,
            border: Border.all(color: DnpColors.borderSubtle),
            borderRadius: BorderRadius.circular(DnpRadius.pill),
          ),
          child: Row(
            children: [
              for (final key in CategoryKey.values)
                Expanded(
                  child: _TabSegment(
                    label: categoryLabelForKey(key, language),
                    active: controller.index == key.index,
                    onTap: () => controller.animateTo(key.index),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _TabSegment extends StatelessWidget {
  const _TabSegment({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      semanticLabel: label,
      scaleOnPress: false,
      builder: (context, hovered, pressed) => AnimatedContainer(
        duration: DnpMotion.durFast,
        curve: DnpMotion.easeInOut,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? DnpColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(DnpRadius.pill),
        ),
        child: Text(
          label,
          style: DnpType.segmentedLabel.copyWith(
            color: active ? DnpColors.textOnAccent : DnpColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
