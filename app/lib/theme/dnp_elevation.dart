import 'package:flutter/widgets.dart';

/// Shadow tokens — a direct port of `tokens/elevation.css`. On this dark
/// surface, depth mostly comes from surface lightness plus a hairline;
/// these shadows are reserved for layers that actually float (sheets,
/// menus) — cards use a border, not a shadow.
class DnpShadow {
  DnpShadow._();

  static const sm = [
    BoxShadow(color: Color(0x66000000), offset: Offset(0, 1), blurRadius: 2),
  ];

  static const md = [
    BoxShadow(color: Color(0x73000000), offset: Offset(0, 4), blurRadius: 16),
  ];

  static const lg = [
    BoxShadow(color: Color(0x8C000000), offset: Offset(0, 12), blurRadius: 40),
  ];

  static const accent = [
    BoxShadow(color: Color(0x2EB8E62E), offset: Offset(0, 6), blurRadius: 20),
  ];
}
