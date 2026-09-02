import 'package:flutter/material.dart';

import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';

/// Decompressed record body text. Paragraphs are split on blank lines — the
/// decompressed payload is plain text with no markup, so no headings,
/// bullet lists, or bold runs are invented here.
class ArticleBody extends StatelessWidget {
  const ArticleBody({super.key, required this.text, this.lead = false});

  final String text;
  final bool lead;

  @override
  Widget build(BuildContext context) {
    final paragraphs = text.split(RegExp(r'\n\s*\n')).where((p) => p.trim().isNotEmpty).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < paragraphs.length; i++) ...[
          if (i > 0) const SizedBox(height: DnpSpace.s4),
          Text(
            paragraphs[i],
            style: i == 0 && lead
                ? DnpType.subheadingRegular.copyWith(color: DnpColors.textPrimary)
                : DnpType.body.copyWith(color: DnpColors.textBody),
          ),
        ],
      ],
    );
  }
}
