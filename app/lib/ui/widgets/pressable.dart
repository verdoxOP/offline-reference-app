import 'package:flutter/material.dart';

import '../../theme/dnp_motion.dart';

/// Shared tap/hover/press affordance used by every interactive DNP
/// component. Per the design system's motion rules: hover steps a surface
/// one level lighter (handled by the caller's [builder]), press is always
/// felt as `scale(.97)` over 90ms — never color alone.
class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.builder,
    this.onTap,
    this.semanticLabel,
    this.scaleOnPress = true,
  });

  final Widget Function(BuildContext context, bool hovered, bool pressed) builder;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool scaleOnPress;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _hovered = false;
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    Widget child = widget.builder(context, _hovered, _pressed);
    if (widget.scaleOnPress) {
      child = AnimatedScale(
        scale: _pressed && enabled ? DnpMotion.pressScale : 1.0,
        duration: DnpMotion.durInstant,
        curve: DnpMotion.easeInOut,
        child: child,
      );
    }
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      enabled: enabled,
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() {
          _hovered = false;
          _pressed = false;
        }),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          onTapDown: enabled ? (_) => _setPressed(true) : null,
          onTapUp: enabled ? (_) => _setPressed(false) : null,
          onTapCancel: enabled ? () => _setPressed(false) : null,
          child: child,
        ),
      ),
    );
  }
}
