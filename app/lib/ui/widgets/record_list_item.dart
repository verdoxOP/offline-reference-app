import 'package:flutter/material.dart';

import '../../theme/dnp_colors.dart';
import '../../theme/dnp_motion.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import '../category_icons.dart';
import 'pressable.dart';

/// A single topic row in the browse/search list. Tap opens the record
/// detail.
class RecordListItem extends StatelessWidget {
  const RecordListItem({
    super.key,
    required this.title,
    required this.category,
    this.thumbnail,
    this.onTap,
    this.compressed = false,
  });

  final String title;
  final String category;
  final String? thumbnail;
  final VoidCallback? onTap;
  final bool compressed;

  @override
  Widget build(BuildContext context) {
    final meta = categoryMeta(category);
    return Pressable(
      onTap: onTap,
      semanticLabel: title,
      scaleOnPress: false,
      builder: (context, hovered, pressed) => AnimatedContainer(
        duration: DnpMotion.durFast,
        curve: DnpMotion.easeInOut,
        constraints: const BoxConstraints(minHeight: DnpLayout.rowHeight),
        padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4, vertical: DnpSpace.s3),
        decoration: BoxDecoration(
          color: hovered ? DnpColors.surface3 : DnpColors.surface2,
          border: Border.all(color: DnpColors.borderSubtle),
          borderRadius: BorderRadius.circular(DnpRadius.md),
        ),
        child: Row(
          children: [
            _Thumbnail(thumbnail: thumbnail, meta: meta),
            const SizedBox(width: DnpSpace.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: DnpType.listItemTitle.copyWith(color: DnpColors.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(category.toUpperCase(), style: DnpType.label.copyWith(color: meta.color)),
                      if (compressed) ...[
                        const SizedBox(width: 8),
                        Text(
                          '· zstd',
                          style: DnpType.label.copyWith(color: DnpColors.textMuted, letterSpacing: 0.5),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: hovered ? DnpColors.textSecondary : DnpColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.thumbnail, required this.meta});

  final String? thumbnail;
  final CategoryMeta meta;

  @override
  Widget build(BuildContext context) {
    const size = 48.0;
    if (thumbnail == null) {
      return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: meta.quiet, borderRadius: BorderRadius.circular(DnpRadius.sm)),
        child: Icon(meta.icon, size: 22, color: meta.color),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(DnpRadius.sm),
      child: ColorFiltered(
        // The design's thumbnail treatment is CSS `saturate(.85) contrast(1.05)
        // brightness(.92)`; this is that same chain composed into one 4x5
        // color matrix (see MediaHeader for the derivation of this approach).
        colorFilter: const ColorFilter.matrix(<double>[
          0.8520, 0.1036, 0.0104, 0, -5.888,
          0.0309, 0.9247, 0.0104, 0, -5.888,
          0.0309, 0.1036, 0.8315, 0, -5.888,
          0, 0, 0, 1, 0,
        ]),
        child: Image.asset(
          thumbnail!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: size,
            height: size,
            color: DnpColors.surface4,
          ),
        ),
      ),
    );
  }
}
