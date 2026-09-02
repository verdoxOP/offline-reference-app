import 'package:flutter/material.dart';

import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import '../category_icons.dart';

/// Small category label. Color and icon follow the dataset's four
/// categories (see [categoryMeta]).
class CategoryBadge extends StatelessWidget {
  const CategoryBadge({
    super.key,
    required this.category,
    this.soft = true,
    this.showIcon = true,
  });

  final String category;
  final bool soft;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final meta = categoryMeta(category);
    return Container(
      height: 24,
      padding: soft ? const EdgeInsets.symmetric(horizontal: DnpSpace.s3) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: soft ? meta.quiet : Colors.transparent,
        borderRadius: BorderRadius.circular(DnpRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(meta.icon, size: 14, color: meta.color),
            const SizedBox(width: 6),
          ],
          Text(
            category.toUpperCase(),
            style: DnpType.label.copyWith(color: meta.color),
          ),
        ],
      ),
    );
  }
}
