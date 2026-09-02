import 'package:flutter/material.dart';

/// Maps a record's category (nl or en) to a Material icon. Categories are
/// small and fixed (Basis/Nood/Kaart/FAQ), so a lookup table is simpler and
/// lighter than shipping per-category icon assets.
IconData iconForCategory(String? category) {
  switch (category) {
    case 'Basis':
    case 'Basics':
      return Icons.inventory_2_outlined;
    case 'Nood':
    case 'Emergency':
      return Icons.warning_amber_rounded;
    case 'Kaart':
    case 'Map':
      return Icons.map_outlined;
    case 'FAQ':
      return Icons.help_outline;
    default:
      return Icons.info_outline;
  }
}
