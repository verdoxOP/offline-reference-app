import 'dart:ui';

import 'package:flutter/material.dart';

import '../../i18n/localization.dart';
import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import 'pressable.dart';

/// Top bar: optional back affordance, title, and trailing actions (e.g. a
/// [LanguageToggle]). Sticky and translucent — blur is used only here and
/// on the map's zoom control, never as decoration.
class DnpAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DnpAppBar({
    super.key,
    required this.title,
    required this.language,
    this.onBack,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final AppLanguage language;
  final VoidCallback? onBack;
  final String? subtitle;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(DnpLayout.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          constraints: const BoxConstraints(minHeight: DnpLayout.appBarHeight),
          padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4),
          decoration: BoxDecoration(
            color: DnpColors.surface1.withOpacity(0.86),
            border: const Border(bottom: BorderSide(color: DnpColors.borderSubtle)),
          ),
          child: Row(
            children: [
              if (onBack != null)
                Padding(
                  padding: const EdgeInsets.only(right: DnpSpace.s3),
                  child: Pressable(
                    onTap: onBack,
                    semanticLabel: Strings.of(language, 'back'),
                    builder: (context, hovered, pressed) => Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: hovered ? DnpColors.surface3 : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, size: 22, color: DnpColors.textPrimary),
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: DnpType.heading.copyWith(color: DnpColors.textPrimary),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: DnpType.small.copyWith(color: DnpColors.textMuted, height: 1.3),
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
