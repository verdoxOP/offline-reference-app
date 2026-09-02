import 'package:flutter/widgets.dart';

/// DNP design system color tokens: a near-black blue-slate ramp with one
/// signal-lime accent and four category hues. See the design system's
/// `tokens/colors.css` — values here are a direct port.
class DnpColors {
  DnpColors._();

  // Base neutral ramp.
  static const slate1000 = Color(0xFF07090C);
  static const slate950 = Color(0xFF0D1117);
  static const slate900 = Color(0xFF12171F);
  static const slate850 = Color(0xFF171D26);
  static const slate800 = Color(0xFF1C242F);
  static const slate700 = Color(0xFF28323F);
  static const slate600 = Color(0xFF3A4654);
  static const slate500 = Color(0xFF55636F);
  static const slate400 = Color(0xFF7C8896);
  static const slate300 = Color(0xFFA3AEBB);
  static const slate200 = Color(0xFFC8D0DA);
  static const slate100 = Color(0xFFE6EAF0);

  // Signal lime: the single brand accent.
  static const lime400 = Color(0xFFC7EF55);
  static const lime500 = Color(0xFFB8E62E);
  static const lime600 = Color(0xFF9BC81F);
  static const lime700 = Color(0xFF6F8F16);
  static const limeTint12 = Color(0x1FB8E62E);
  static const limeTint20 = Color(0x33B8E62E);

  // Semantic hues for the four content categories + status.
  static const red500 = Color(0xFFFF4D4D);
  static const red600 = Color(0xFFD93636);
  static const redHover = Color(0xFFFF6666);
  static const redTint12 = Color(0x1FFF4D4D);

  static const amber500 = Color(0xFFFFB020);
  static const amberTint12 = Color(0x1FFFB020);

  static const cyan500 = Color(0xFF3FC8DE);
  static const cyanTint12 = Color(0x1F3FC8DE);

  static const violet500 = Color(0xFF9B8CFF);
  static const violetTint12 = Color(0x1F9B8CFF);

  // Semantic aliases — use these, not the ramp, in widgets.
  static const bgApp = slate1000;
  static const surface1 = slate950; // screen background
  static const surface2 = slate900; // cards, list rows
  static const surface3 = slate850; // raised: sheets, inputs
  static const surface4 = slate800; // hover / pressed fill
  static const surfaceInverse = slate100;
  static const scrim = Color(0xB8070A0C);

  static const textPrimary = slate100;
  static const textBody = slate200;
  static const textSecondary = slate400;
  static const textMuted = slate500;
  static const textOnAccent = slate1000;
  static const textInverse = slate1000;

  static const borderSubtle = Color(0x0FFFFFFF);
  static const borderDefault = Color(0x1AFFFFFF);
  static const borderStrong = Color(0x2EFFFFFF);
  static const borderFocus = lime500;

  static const accent = lime500;
  static const accentHover = lime400;
  static const accentPress = lime600;
  static const accentQuiet = limeTint12;

  static const danger = red500;
  static const dangerHover = redHover;
  static const dangerQuiet = redTint12;
  static const warning = amber500;
  static const warningQuiet = amberTint12;
  static const info = cyan500;
  static const infoQuiet = cyanTint12;

  // Category colors, keyed to the four seed-content categories.
  static const catBasis = lime500;
  static const catBasisQuiet = limeTint12;
  static const catNood = red500;
  static const catNoodQuiet = redTint12;
  static const catKaart = cyan500;
  static const catKaartQuiet = cyanTint12;
  static const catFaq = violet500;
  static const catFaqQuiet = violetTint12;

  // Image protection scrim (top-to-bottom gradient over full-bleed photos).
  static const imageScrimTop = Color(0x8C07090C); // rgba(7,9,12,.55)
  static const imageScrimBottom = Color(0xD907090C); // rgba(7,9,12,.85)
}
