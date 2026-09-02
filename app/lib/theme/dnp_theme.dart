import 'package:flutter/material.dart';

import 'dnp_colors.dart';
import 'dnp_typography.dart';

/// The DNP design system's dark theme. Deep, quiet, instrument-like: the
/// app gets opened in a blackout, at 3am, at low brightness — so surfaces
/// stay near-black, type stays high-contrast, and exactly one loud color
/// (signal lime) exists.
class DnpTheme {
  DnpTheme._();

  static ThemeData build() {
    final colorScheme = const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: DnpColors.accent,
      onPrimary: DnpColors.textOnAccent,
      secondary: DnpColors.accent,
      onSecondary: DnpColors.textOnAccent,
      error: DnpColors.danger,
      onError: DnpColors.slate1000,
      surface: DnpColors.surface1,
      onSurface: DnpColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: DnpColors.surface1,
      canvasColor: DnpColors.surface1,
      fontFamily: DnpFonts.sans,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: DnpColors.limeTint20,
        cursorColor: DnpColors.accent,
        selectionHandleColor: DnpColors.accent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: DnpColors.surface1,
        foregroundColor: DnpColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: TextTheme(
        displayLarge: DnpType.display.copyWith(color: DnpColors.textPrimary),
        titleLarge: DnpType.title.copyWith(color: DnpColors.textPrimary),
        headlineSmall: DnpType.heading.copyWith(color: DnpColors.textPrimary),
        bodyMedium: DnpType.body.copyWith(color: DnpColors.textBody),
        labelSmall: DnpType.label.copyWith(color: DnpColors.textSecondary),
      ),
      dividerColor: DnpColors.borderSubtle,
      iconTheme: const IconThemeData(color: DnpColors.textSecondary),
    );
  }
}
