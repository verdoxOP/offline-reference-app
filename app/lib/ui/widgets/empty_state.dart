import 'package:flutter/material.dart';

import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';

/// No-results / nothing-here state. Mirrors the app's "Geen resultaten
/// gevonden".
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.icon = Icons.search_off,
    required this.title,
    this.description,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s6, vertical: DnpSpace.s10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: DnpColors.surface3,
              shape: BoxShape.circle,
              border: Border.all(color: DnpColors.borderSubtle),
            ),
            child: Icon(icon, size: 26, color: DnpColors.textMuted),
          ),
          const SizedBox(height: DnpSpace.s3),
          Text(
            title,
            textAlign: TextAlign.center,
            style: DnpType.heading.copyWith(color: DnpColors.textPrimary),
          ),
          if (description != null) ...[
            const SizedBox(height: DnpSpace.s3),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                description!,
                textAlign: TextAlign.center,
                style: DnpType.small.copyWith(color: DnpColors.textSecondary, height: 1.5),
              ),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: DnpSpace.s2),
            action!,
          ],
        ],
      ),
    );
  }
}
