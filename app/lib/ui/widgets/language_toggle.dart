import 'package:flutter/material.dart';

import '../../i18n/localization.dart';
import '../../theme/dnp_colors.dart';
import '../../theme/dnp_motion.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import 'pressable.dart';

/// NL / EN segmented switch — drives both UI strings and which language's
/// records are queried.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key, required this.value, required this.onChanged});

  final AppLanguage value;
  final ValueChanged<AppLanguage> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: DnpColors.surface3,
        border: Border.all(color: DnpColors.borderDefault),
        borderRadius: BorderRadius.circular(DnpRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: AppLanguage.values.map((lang) {
          final active = value == lang;
          return Padding(
            padding: EdgeInsets.only(left: lang == AppLanguage.en ? 2 : 0),
            child: Pressable(
              onTap: () => onChanged(lang),
              scaleOnPress: false,
              builder: (context, hovered, pressed) => AnimatedContainer(
                duration: DnpMotion.durFast,
                curve: DnpMotion.easeInOut,
                height: 34,
                constraints: const BoxConstraints(minWidth: 40),
                padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? DnpColors.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(DnpRadius.pill),
                ),
                child: Text(
                  lang.code.toUpperCase(),
                  style: DnpType.segmentedLabel.copyWith(
                    color: active ? DnpColors.textOnAccent : DnpColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
