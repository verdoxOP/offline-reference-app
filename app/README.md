# Flutter App

Run:

```bash
flutter pub get
flutter run
```

Offline-first: on first launch, `AppDatabase.open()` copies the bundled `assets/data/dataset.isar` into local storage and opens it directly — there's no in-app import feature. Records are queried from Isar, filtered by the selected language; each record's compressed payload is decompressed on demand via `DecompressService`, which calls the system zstd library through Dart FFI (`lib/native/zstd_bindings.dart`) off the UI thread.

## Features

- **Search** (`lib/ui/home.dart`) — an Isar query filtered on indexed `title`/`category`.
- **Dutch/English** (`lib/i18n/localization.dart`) — a lightweight language controller (no `intl`/`flutter_localizations` dependency) drives an NL/EN toggle; every `Record` has a `language` field and a `topicId` linking its nl/en pair.
- **Kaart** — the Noodsteunpunten/Watertappunten topics show a real, self-rendered map of Tilburg (`assets/images/kaart_tilburg.jpg`) with icon markers for real hospitals/police/fire stations/water taps. The header image is wrapped in Flutter's `InteractiveViewer` for pan/pinch-zoom (`lib/ui/record_detail.dart`) — still just a static bundled image, not live map tiles.

To rebuild `assets/data/dataset.isar` from a fresh pipeline export, see [`tool/import_dataset.dart`](tool/import_dataset.dart) and the root [`docs/SETUP.md`](../docs/SETUP.md). Until the authoring backend has real content, [`tool/generate_seed_dataset.dart`](tool/generate_seed_dataset.dart) builds the dataset from the checked-in [`pipeline/seed/content.json`](../pipeline/seed/content.json) instead.
