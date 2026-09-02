import 'package:flutter/foundation.dart';

/// The two languages the shipped dataset and UI support. Content is stored
/// per-language in Isar (see Record.language); this only drives which
/// language is queried and which UI strings are shown.
enum AppLanguage {
  nl,
  en;

  String get code => this == AppLanguage.nl ? 'nl' : 'en';

  AppLanguage get other => this == AppLanguage.nl ? AppLanguage.en : AppLanguage.nl;
}

/// Holds the currently selected UI/content language. Small enough that a
/// full localization framework (intl/flutter_localizations) isn't worth the
/// dependency weight for this handful of strings.
class AppLanguageController extends ValueNotifier<AppLanguage> {
  AppLanguageController(super.initial);
}

class Strings {
  Strings._();

  static const Map<String, Map<String, String>> _values = {
    'appTitle': {'nl': 'Offline Naslagwerk', 'en': 'Offline Reference'},
    'searchHint': {'nl': 'Zoek titel of categorie', 'en': 'Search title or category'},
    'noResults': {'nl': 'Geen resultaten gevonden', 'en': 'No matching records'},
    'noDetails': {'nl': 'Geen details beschikbaar.', 'en': 'No details available.'},
  };

  static String of(AppLanguage language, String key) => _values[key]![language.code]!;
}
