import 'package:flutter/animation.dart';

/// Motion tokens — a direct port of `tokens/motion.css`. 90-340ms, no
/// bounce or spring anywhere in the system.
class DnpMotion {
  DnpMotion._();

  static const durInstant = Duration(milliseconds: 90);
  static const durFast = Duration(milliseconds: 140);
  static const durBase = Duration(milliseconds: 220);
  static const durSlow = Duration(milliseconds: 340);

  static const easeStandard = Cubic(0.2, 0, 0, 1);
  static const easeOut = Cubic(0.16, 1, 0.3, 1);
  static const easeInOut = Cubic(0.4, 0, 0.2, 1);

  /// `transform: scale(.97)` on press — felt as scale, never color alone.
  static const pressScale = 0.97;
}
