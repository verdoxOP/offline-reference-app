# Flutter App

Run:

```bash
flutter pub get
flutter run
```

Offline-first: on first launch, `AppDatabase.open()` copies the bundled `assets/data/dataset.isar` into local storage and opens it directly — there's no in-app import feature. Records are queried from Isar; each record's compressed payload is decompressed on demand via `DecompressService`, which calls the system zstd library through Dart FFI (`lib/native/zstd_bindings.dart`) off the UI thread.

To rebuild `assets/data/dataset.isar` from a fresh pipeline export, see [`tool/import_dataset.dart`](tool/import_dataset.dart) and the root [`docs/SETUP.md`](../docs/SETUP.md).
