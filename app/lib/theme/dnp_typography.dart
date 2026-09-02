import 'package:flutter/widgets.dart';

/// Font family names. Bundled as static local assets (see pubspec.yaml) —
/// no CDN, so the app's offline guarantee holds for type as well as data.
class DnpFonts {
  DnpFonts._();

  static const display = 'Archivo';
  static const sans = 'Instrument Sans';
  static const mono = 'JetBrains Mono';
}

TextStyle _style({
  required String family,
  required FontWeight weight,
  required double size,
  required double height,
  double trackingEm = 0,
}) {
  return TextStyle(
    fontFamily: family,
    fontWeight: weight,
    fontSize: size,
    height: height,
    letterSpacing: trackingEm * size,
  );
}

/// DNP type roles — a direct port of `tokens/typography.css`. Color is left
/// unset here (applied per use-site via `copyWith`), matching how the
/// design system separates `font` shorthand from `color`.
class DnpType {
  DnpType._();

  static final display = _style(
    family: DnpFonts.display,
    weight: FontWeight.w700,
    size: 34,
    height: 1.06,
    trackingEm: -0.02,
  );

  static final title = _style(
    family: DnpFonts.display,
    weight: FontWeight.w600,
    size: 24,
    height: 1.16,
    trackingEm: -0.015,
  );

  static final heading = _style(
    family: DnpFonts.display,
    weight: FontWeight.w600,
    size: 19,
    height: 1.3,
    trackingEm: -0.015,
  );

  static final subheadingRegular = _style(
    family: DnpFonts.sans,
    weight: FontWeight.w400,
    size: 17,
    height: 1.5,
  );

  static final body = _style(
    family: DnpFonts.sans,
    weight: FontWeight.w400,
    size: 15,
    height: 1.55,
  );

  static final small = _style(
    family: DnpFonts.sans,
    weight: FontWeight.w400,
    size: 13,
    height: 1.45,
  );

  static final smallMedium = _style(
    family: DnpFonts.sans,
    weight: FontWeight.w500,
    size: 13,
    height: 1.4,
  );

  /// Category eyebrow / uppercase label role — Instrument Sans 600, 11px,
  /// +0.09em tracking. Always rendered uppercase by the caller.
  static final label = _style(
    family: DnpFonts.sans,
    weight: FontWeight.w600,
    size: 11,
    height: 1.2,
    trackingEm: 0.09,
  );

  // --- Component-specific composites (values copied verbatim from each
  // component's source rather than re-derived from the five roles above). ---

  static TextStyle buttonLabel(double fontSize) => _style(
        family: DnpFonts.display,
        weight: FontWeight.w600,
        size: fontSize,
        height: 1,
        trackingEm: -0.005,
      );

  static final listItemTitle = _style(
    family: DnpFonts.display,
    weight: FontWeight.w600,
    size: 17,
    height: 1.25,
    trackingEm: -0.01,
  );

  static final segmentedLabel = _style(
    family: DnpFonts.display,
    weight: FontWeight.w600,
    size: 13,
    height: 1,
    trackingEm: 0.04,
  );

  static final chipLabel = _style(
    family: DnpFonts.sans,
    weight: FontWeight.w500,
    size: 13,
    height: 1,
  );

  static TextStyle mono(double size, {FontWeight weight = FontWeight.w500}) {
    return TextStyle(
      fontFamily: DnpFonts.mono,
      fontWeight: weight,
      fontSize: size,
      height: 1,
    );
  }

  static final brandWordmark = _style(
    family: DnpFonts.display,
    weight: FontWeight.w700,
    size: 27,
    height: 1.06,
    trackingEm: -0.02,
  );

  static final brandLine = _style(
    family: DnpFonts.sans,
    weight: FontWeight.w500,
    size: 13,
    height: 1.4,
  );
}
