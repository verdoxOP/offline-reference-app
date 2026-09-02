import 'package:flutter/material.dart';

import '../../theme/dnp_colors.dart';
import '../../theme/dnp_motion.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import 'pressable.dart';

const double _hitTarget = DnpLayout.hitTarget;

enum DnpButtonVariant { primary, secondary, ghost, danger }

enum DnpButtonSize { sm, md, lg }

/// The app's action button. The Flutter source only has one button (the
/// app bar's NL/EN toggle, its own [LanguageToggle] here) — this general
/// button is an intentional addition for the emergency call action and any
/// future screen.
class DnpButton extends StatelessWidget {
  const DnpButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = DnpButtonVariant.primary,
    this.size = DnpButtonSize.md,
    this.icon,
    this.iconEnd,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final DnpButtonVariant variant;
  final DnpButtonSize size;
  final IconData? icon;
  final IconData? iconEnd;
  final bool fullWidth;

  double get _minHeight => switch (size) {
        DnpButtonSize.sm => 36,
        DnpButtonSize.md => _hitTarget,
        DnpButtonSize.lg => 56,
      };

  double get _fontSize => switch (size) {
        DnpButtonSize.sm => 13,
        DnpButtonSize.md => 15,
        DnpButtonSize.lg => 17,
      };

  EdgeInsets get _padding => switch (size) {
        DnpButtonSize.sm => const EdgeInsets.symmetric(horizontal: DnpSpace.s4),
        DnpButtonSize.md => const EdgeInsets.symmetric(horizontal: DnpSpace.s6),
        DnpButtonSize.lg => const EdgeInsets.symmetric(horizontal: DnpSpace.s8),
      };

  ({Color bg, Color fg, Color? border}) _colors(bool hovered) {
    switch (variant) {
      case DnpButtonVariant.primary:
        return (
          bg: hovered ? DnpColors.accentHover : DnpColors.accent,
          fg: DnpColors.textOnAccent,
          border: null,
        );
      case DnpButtonVariant.secondary:
        return (
          bg: hovered ? DnpColors.surface4 : DnpColors.surface3,
          fg: DnpColors.textPrimary,
          border: hovered ? DnpColors.borderStrong : DnpColors.borderDefault,
        );
      case DnpButtonVariant.ghost:
        return (
          bg: hovered ? DnpColors.surface3 : Colors.transparent,
          fg: hovered ? DnpColors.textPrimary : DnpColors.textSecondary,
          border: null,
        );
      case DnpButtonVariant.danger:
        return (
          bg: hovered ? DnpColors.dangerHover : DnpColors.danger,
          fg: DnpColors.slate1000,
          border: null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    return Pressable(
      onTap: onPressed,
      semanticLabel: label,
      builder: (context, hovered, pressed) {
        final colors = _colors(hovered && !disabled);
        return Opacity(
          opacity: disabled ? 0.38 : 1,
          child: AnimatedContainer(
            duration: DnpMotion.durFast,
            curve: DnpMotion.easeInOut,
            width: fullWidth ? double.infinity : null,
            constraints: BoxConstraints(minHeight: _minHeight),
            padding: _padding,
            decoration: BoxDecoration(
              color: colors.bg,
              borderRadius: BorderRadius.circular(DnpRadius.pill),
              border: colors.border != null ? Border.all(color: colors.border!) : null,
            ),
            child: Row(
              mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: colors.fg),
                  const SizedBox(width: DnpSpace.s2),
                ],
                Text(
                  label,
                  style: DnpType.buttonLabel(_fontSize).copyWith(color: colors.fg),
                ),
                if (iconEnd != null) ...[
                  const SizedBox(width: DnpSpace.s2),
                  Icon(iconEnd, size: 20, color: colors.fg),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
