import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../category_icons.dart';
import 'pressable.dart';

/// The design's photo treatment — CSS `saturate(.9) contrast(1.06)
/// brightness(.9)` — composed into one 4x5 color matrix (saturate via the
/// standard SVG luminance-weighted matrix, then contrast and brightness
/// folded into its scale/translate terms).
const _imageFilter = ColorFilter.matrix(<double>[
  0.8789, 0.0682, 0.0069, 0, -6.912,
  0.0203, 0.9268, 0.0069, 0, -6.912,
  0.0203, 0.0682, 0.8655, 0, -6.912,
  0, 0, 0, 1, 0,
]);

/// Full-bleed image header for a record detail screen. [interactive]
/// switches to the pan/zoom treatment the app uses for the Tilburg map
/// (backed by [InteractiveViewer], same as the original `record_detail.dart`).
class MediaHeader extends StatefulWidget {
  const MediaHeader({
    super.key,
    this.imageAsset,
    required this.category,
    this.height = 200,
    this.interactive = false,
    this.child,
  });

  final String? imageAsset;
  final String category;
  final double height;
  final bool interactive;
  final Widget? child;

  @override
  State<MediaHeader> createState() => _MediaHeaderState();
}

class _MediaHeaderState extends State<MediaHeader> {
  final _controller = TransformationController();
  double _scale = 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _zoom(double factor) {
    final next = (_scale * factor).clamp(1.0, 8.0);
    if (next == _scale) return;
    setState(() => _scale = next);
    _controller.value = Matrix4.identity()..scaleByDouble(next, next, next, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final meta = categoryMeta(widget.category);

    if (widget.imageAsset == null) {
      return Container(
        height: 120,
        width: double.infinity,
        color: meta.quiet,
        alignment: Alignment.center,
        child: Icon(meta.icon, size: 48, color: meta.color),
      );
    }

    final image = ColorFiltered(
      colorFilter: _imageFilter,
      child: Image.asset(widget.imageAsset!, fit: BoxFit.cover),
    );

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: DnpColors.surface4,
            child: widget.interactive
                ? InteractiveViewer(
                    transformationController: _controller,
                    minScale: 1,
                    maxScale: 8,
                    child: image,
                  )
                : image,
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.38, 1],
                  colors: [
                    DnpColors.imageScrimTop,
                    Colors.transparent,
                    DnpColors.imageScrimBottom,
                  ],
                ),
              ),
            ),
          ),
          if (widget.interactive)
            Positioned(
              right: DnpSpace.s4,
              bottom: DnpSpace.s4,
              child: _ZoomControl(onZoomIn: () => _zoom(1.5), onZoomOut: () => _zoom(1 / 1.5)),
            ),
          if (widget.child != null)
            Positioned(
              left: DnpSpace.s4,
              right: DnpSpace.s4,
              bottom: DnpSpace.s4,
              child: widget.child!,
            ),
        ],
      ),
    );
  }
}

class _ZoomControl extends StatelessWidget {
  const _ZoomControl({required this.onZoomIn, required this.onZoomOut});

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(DnpRadius.sm),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: DnpColors.borderDefault)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ZoomButton(icon: Icons.add, onTap: onZoomIn),
              Container(height: 1, color: DnpColors.borderSubtle),
              _ZoomButton(icon: Icons.remove, onTap: onZoomOut),
            ],
          ),
        ),
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      scaleOnPress: false,
      builder: (context, hovered, pressed) => Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        color: DnpColors.surface2.withValues(alpha: 0.82),
        child: Icon(icon, size: 18, color: DnpColors.textPrimary),
      ),
    );
  }
}
