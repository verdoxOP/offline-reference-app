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
    'overview': {'nl': 'Overzicht', 'en': 'Overview'},
    'settings': {'nl': 'Instellingen', 'en': 'Settings'},
    'language': {'nl': 'Taal', 'en': 'Language'},
    'statusOk': {
      'nl': 'Er is op dit moment geen landelijke stroomuitval.',
      'en': 'There is currently no nationwide power outage.',
    },
    'statusOkEmphasis': {'nl': 'geen landelijke stroomuitval', 'en': 'no nationwide power outage'},
    'viewOfflineMap': {'nl': 'Bekijk offline kaart', 'en': 'View offline map'},
    'viewOfflineMapDetail': {
      'nl': 'Vind belangrijke locaties bij jou in de buurt',
      'en': 'Find important locations near you',
    },
    'filterLocations': {'nl': 'Filter locaties', 'en': 'Filter locations'},
    'filterLocationsDetail': {
      'nl': 'Toon alleen de locaties die je nodig hebt',
      'en': 'Show only the locations you need',
    },
    'myLocation': {'nl': 'Mijn locatie', 'en': 'My location'},
    'myLocationDetail': {
      'nl': 'Zie waar je je nu bevindt (offline)',
      'en': "See where you're currently located (offline)",
    },
    'myLocationUnavailable': {
      'nl': 'Locatievoorziening niet beschikbaar op dit toestel.',
      'en': "Location services aren't available on this device.",
    },
    'locating': {'nl': 'Locatie zoeken…', 'en': 'Locating…'},
    'downloadMap': {'nl': 'Kaart downloaden', 'en': 'Download map'},
    'downloadMapDetail': {
      'nl': 'Sla de kaart van jouw regio op voor offline gebruik',
      'en': 'Save the map of your region for offline use',
    },
    'downloadMapAlready': {'nl': 'Al gedownload', 'en': 'Already downloaded'},
    'searchLocation': {'nl': 'Zoek locatie...', 'en': 'Search location...'},
    'mapFilterAll': {'nl': 'Alle', 'en': 'All'},
    'mapFilterSupport': {'nl': 'Noodsteun', 'en': 'Support points'},
    'mapFilterHospitals': {'nl': 'Ziekenhuizen', 'en': 'Hospitals'},
    'mapFilterPolice': {'nl': 'Politie', 'en': 'Police'},
    'information': {'nl': 'Informatie', 'en': 'Information'},
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
