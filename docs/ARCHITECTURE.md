# Architecture

Layers:

- **Authoring backend**: Spring Boot + PostgreSQL. Provides a CRUD admin API for content records (including `topicId`/`language`). Used only during content authoring/export, never shipped to users. Not yet populated with real content.
- **Seed content**: until the authoring backend is populated, `pipeline/seed/content.json` is the source of truth — bilingual (nl/en) title/category/body per topic, checked into git. `app/tool/generate_seed_dataset.dart` turns it into `records.jsonl` in the same shape the real pipeline produces, as a stand-in for `pipeline/index.js`.
- **Build pipeline**: `pipeline/index.js` connects to Postgres, exports content, and compresses each record's large text field with zstd. Writes `records.jsonl` — plaintext searchable columns (`topicId`, `language`, `title`, `category`) plus a base64 zstd-compressed payload for the large field, so nothing large is stored twice.
- **Dataset import**: `app/tool/import_dataset.dart` (build-time only, plain Dart, no Flutter dependency) reads `records.jsonl` and writes it into an Isar database (`dataset.isar`). Every topic has one Record per language, linked by `topicId`.
- **Mobile app**: Flutter app that ships with the pre-built `dataset.isar` as a bundled asset. On first launch it's copied into the app's local storage; after that it's opened directly. Uses Isar for local queries (filtered by the selected `language`) and Dart FFI bindings to the system zstd library for on-device, on-demand decompression — a record's compressed payload is only decompressed when that record is actually opened, off the UI thread. A language toggle (`lib/i18n/localization.dart`) switches both UI strings and which language's records are queried. There is no in-app import path.

## Compression boundary

Compression happens per-record, not per-database:

```
Isar query (indexed on title/category)
        ↓
matching Record
        ↓
compressedPayload (zstd bytes)
        ↓
zstd decompression (off the UI thread)
        ↓
Display
```

Searching or browsing never requires decompressing unrelated records, and the app never decompresses the full dataset into memory.
