import 'package:flutter/material.dart';

import '../../i18n/localization.dart';
import '../../theme/dnp_colors.dart';
import '../../theme/dnp_motion.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import '../category_icons.dart';
import 'pressable.dart';

/// One entry in a [CategoryTabs] strip. [key] is `null` for the "all" tab.
class CategoryTabItem {
  const CategoryTabItem({required this.key, required this.label, this.count});

  final CategoryKey? key;
  final String label;
  final int? count;
}

/// Horizontal category filter chips over the record list. Intentional
/// addition: `home.dart` has no way to filter by category, but with 17+
/// records (and a 500 MB dataset ahead) browsing needs it.
class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<CategoryTabItem> items;
  final CategoryKey? value;
  final ValueChanged<CategoryKey?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: DnpSpace.s2),
        itemBuilder: (context, i) {
          final item = items[i];
          final active = value == item.key;
          final meta = item.key != null
              ? categoryMeta(categoryLabelForKey(item.key!, AppLanguage.nl))
              : null;
          final color = active ? (meta?.color ?? DnpColors.textSecondary) : DnpColors.textSecondary;
          final icon = _iconFor(item.key);
          return Pressable(
            onTap: () => onChanged(item.key),
            semanticLabel: item.label,
            scaleOnPress: false,
            builder: (context, hovered, pressed) => AnimatedContainer(
              duration: DnpMotion.durFast,
              curve: DnpMotion.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? (meta?.quiet ?? DnpColors.surface2) : DnpColors.surface2,
                border: Border.all(color: active ? color : DnpColors.borderSubtle),
                borderRadius: BorderRadius.circular(DnpRadius.pill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 16, color: color),
                  const SizedBox(width: DnpSpace.s2),
                  Text(item.label, style: DnpType.chipLabel.copyWith(color: color)),
                  if (item.count != null) ...[
                    const SizedBox(width: 6),
                    Text(
                      '${item.count}',
                      style: DnpType.mono(11).copyWith(color: DnpColors.textMuted),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _iconFor(CategoryKey? key) {
    if (key == null) return Icons.apps;
    return categoryMeta(categoryLabelForKey(key, AppLanguage.nl)).icon;
  }
}
