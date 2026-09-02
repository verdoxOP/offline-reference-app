import 'package:flutter/material.dart';

import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';

enum DnpNoticeTone { accent, info }

/// Reassurance strip: everything in DNP works with no network. Intentional
/// addition — it states the product's core promise, which the current UI
/// never otherwise tells the user.
class OfflineNotice extends StatelessWidget {
  const OfflineNotice({
    super.key,
    required this.label,
    this.detail,
    this.tone = DnpNoticeTone.accent,
  });

  final String label;
  final String? detail;
  final DnpNoticeTone tone;

  @override
  Widget build(BuildContext context) {
    final color = tone == DnpNoticeTone.accent ? DnpColors.accent : DnpColors.info;
    final quiet = tone == DnpNoticeTone.accent ? DnpColors.accentQuiet : DnpColors.infoQuiet;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4, vertical: DnpSpace.s3),
      decoration: BoxDecoration(
        color: quiet,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(DnpRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.cloud_off, size: 20, color: color),
          const SizedBox(width: DnpSpace.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: DnpType.smallMedium.copyWith(
                    fontFamily: DnpFonts.display,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: DnpColors.textPrimary,
                  ),
                ),
                if (detail != null)
                  Text(
                    detail!,
                    style: DnpType.small.copyWith(color: DnpColors.textSecondary, height: 1.4),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
