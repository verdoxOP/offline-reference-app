import 'package:flutter/material.dart';

import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';

/// Indeterminate loader shown while a record's zstd payload decompresses.
class DnpSpinner extends StatelessWidget {
  const DnpSpinner({super.key, this.size = 24, this.color = DnpColors.accent, this.label});

  final double size;
  final Color color;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: color,
            backgroundColor: DnpColors.borderDefault,
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: DnpSpace.s3),
          Text(
            label!.toUpperCase(),
            style: DnpType.label.copyWith(color: DnpColors.textMuted),
          ),
        ],
      ],
    );
  }
}
