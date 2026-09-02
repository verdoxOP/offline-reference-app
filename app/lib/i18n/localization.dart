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
    'brandLine': {'nl': 'Digitaal Noodpakket', 'en': 'Digital Emergency Kit'},
    'searchHint': {'nl': 'Zoek titel of categorie', 'en': 'Search title or category'},
    'noResults': {'nl': 'Geen resultaten gevonden', 'en': 'No matching records'},
    'noDetails': {'nl': 'Geen details beschikbaar.', 'en': 'No details available.'},
    'all': {'nl': 'Alles', 'en': 'All'},
    'basis': {'nl': 'Basis', 'en': 'Basics'},
    'nood': {'nl': 'Nood', 'en': 'Emergency'},
    'kaart': {'nl': 'Kaart', 'en': 'Map'},
    'faq': {'nl': 'FAQ', 'en': 'FAQ'},
    'offline': {'nl': 'Volledig offline beschikbaar', 'en': 'Fully available offline'},
    'offlineDetail': {
      'nl': 'Dataset op het toestel, geen netwerk nodig',
      'en': 'Dataset stored on device, no network needed',
    },
    'decompressing': {'nl': 'Uitpakken', 'en': 'Unpacking'},
    'decompressError': {
      'nl': 'Kon de inhoud niet uitpakken.',
      'en': "Couldn't unpack the content.",
    },
    'credits': {'nl': 'Bronnen en licenties', 'en': 'Credits and licenses'},
    'emptyHint': {
      'nl': 'Probeer een andere zoekterm of categorie.',
      'en': 'Try another search term or category.',
    },
    'call112': {'nl': 'Bel 112', 'en': 'Call 112'},
    'back': {'nl': 'Terug', 'en': 'Back'},
    'clear': {'nl': 'Wissen', 'en': 'Clear'},
    'creditsIntro': {
      'nl':
          'Alle afbeeldingen komen van Wikimedia Commons en zijn openlijk gelicentieerd, '
          'verkleind en opnieuw gecodeerd voor de app.',
      'en':
          'All images come from Wikimedia Commons, openly licensed, resized and '
          're-encoded for the app.',
    },
  };

  static String of(AppLanguage language, String key) => _values[key]![language.code]!;
}
