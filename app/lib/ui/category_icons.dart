import 'package:flutter/material.dart';

import '../i18n/localization.dart';
import '../theme/dnp_colors.dart';

/// The four seed-content categories. Fixed and small, so a lookup table is
/// simpler and lighter than shipping per-category icon assets.
enum CategoryKey { basis, nood, kaart, faq }

/// Icon + color for a category, keyed to the dataset's four categories.
/// Category glyphs are fixed and must not be re-picked: Basis ->
/// inventory_2, Nood -> warning_amber, Kaart -> map, FAQ -> help.
class CategoryMeta {
  const CategoryMeta({
    required this.key,
    required this.icon,
    required this.color,
    required this.quiet,
  });

  final CategoryKey? key;
  final IconData icon;
  final Color color;
  final Color quiet;
}

const _basisMeta = CategoryMeta(
  key: CategoryKey.basis,
  icon: Icons.inventory_2_outlined,
  color: DnpColors.catBasis,
  quiet: DnpColors.catBasisQuiet,
);

const _noodMeta = CategoryMeta(
  key: CategoryKey.nood,
  icon: Icons.warning_amber_rounded,
  color: DnpColors.catNood,
  quiet: DnpColors.catNoodQuiet,
);

const _kaartMeta = CategoryMeta(
  key: CategoryKey.kaart,
  icon: Icons.map_outlined,
  color: DnpColors.catKaart,
  quiet: DnpColors.catKaartQuiet,
);

const _faqMeta = CategoryMeta(
  key: CategoryKey.faq,
  icon: Icons.help_outline,
  color: DnpColors.catFaq,
  quiet: DnpColors.catFaqQuiet,
);

/// Fallback for a category string that doesn't match a known key (e.g. no
/// category set on the record).
const _fallbackMeta = CategoryMeta(
  key: null,
  icon: Icons.info_outline,
  color: DnpColors.textSecondary,
  quiet: Color(0x0FFFFFFF),
);

/// Maps a record's category string (nl or en) to its [CategoryKey].
CategoryKey? categoryKeyForLabel(String? category) {
  switch (category) {
    case 'Basis':
    case 'Basics':
      return CategoryKey.basis;
    case 'Nood':
    case 'Emergency':
      return CategoryKey.nood;
    case 'Kaart':
    case 'Map':
      return CategoryKey.kaart;
    case 'FAQ':
      return CategoryKey.faq;
    default:
      return null;
  }
}

/// Maps a [CategoryKey] back to the category string in the given
/// [language] — the inverse of [categoryKeyForLabel]. Used to translate a
/// CategoryTabs filter chip (language-independent key) into the string
/// stored on `Record.category` before querying Isar.
String categoryLabelForKey(CategoryKey key, AppLanguage language) {
  final nl = language == AppLanguage.nl;
  switch (key) {
    case CategoryKey.basis:
      return nl ? 'Basis' : 'Basics';
    case CategoryKey.nood:
      return nl ? 'Nood' : 'Emergency';
    case CategoryKey.kaart:
      return nl ? 'Kaart' : 'Map';
    case CategoryKey.faq:
      return 'FAQ';
  }
}

/// Icon + category color for a category string, with a neutral fallback
/// for records without a recognized category.
CategoryMeta categoryMeta(String? category) {
  switch (categoryKeyForLabel(category)) {
    case CategoryKey.basis:
      return _basisMeta;
    case CategoryKey.nood:
      return _noodMeta;
    case CategoryKey.kaart:
      return _kaartMeta;
    case CategoryKey.faq:
      return _faqMeta;
    case null:
      return _fallbackMeta;
  }
}

/// Retained for the Material icon this app already draws from — kept so
/// any existing call sites keep working after the design system pass.
IconData iconForCategory(String? category) => categoryMeta(category).icon;
