import 'package:flutter/material.dart';

import '../../theme/dnp_colors.dart';
import '../../theme/dnp_motion.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import 'pressable.dart';

/// Live search input — filters records via indexed Isar queries as you type.
class DnpSearchField extends StatefulWidget {
  const DnpSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.placeholder,
    required this.clearLabel,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String placeholder;
  final String clearLabel;

  @override
  State<DnpSearchField> createState() => _DnpSearchFieldState();
}

class _DnpSearchFieldState extends State<DnpSearchField> {
  final _focusNode = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() => _focused = _focusNode.hasFocus));
    widget.controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = widget.controller.text.isNotEmpty;
    return AnimatedContainer(
      duration: DnpMotion.durFast,
      curve: DnpMotion.easeInOut,
      height: DnpLayout.hitTarget,
      padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4),
      decoration: BoxDecoration(
        color: DnpColors.surface3,
        borderRadius: BorderRadius.circular(DnpRadius.md),
        border: Border.all(color: _focused ? DnpColors.borderFocus : DnpColors.borderDefault),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: _focused ? DnpColors.accent : DnpColors.textMuted,
          ),
          const SizedBox(width: DnpSpace.s3),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              style: DnpType.body.copyWith(color: DnpColors.textPrimary),
              cursorColor: DnpColors.accent,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: DnpType.body.copyWith(color: DnpColors.textMuted),
              ),
            ),
          ),
          if (hasValue)
            Pressable(
              onTap: () {
                widget.controller.clear();
                widget.onChanged('');
              },
              semanticLabel: widget.clearLabel,
              scaleOnPress: false,
              builder: (context, hovered, pressed) => Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: DnpColors.surface4,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 16, color: DnpColors.textSecondary),
              ),
            ),
        ],
      ),
    );
  }
}
