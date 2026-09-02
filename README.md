# Offline Reference App

A fully offline-first reference app that ships with a large (~500–600 MB) pre-packaged dataset. No network connectivity is required for any core functionality — the app works in airplane mode.

Large fields are compressed with **Zstandard (zstd)** and stored in **Isar**, decompressed on demand only when a record is actually opened — never the whole dataset at once.

## Structure

This is a multi-root workspace:

| Folder | What it is |
|---|---|
| [`app/`](app) | The Flutter app. Isar for storage, zstd (via Dart FFI) for on-demand decompression. This is the only thing that ships to users. |
| [`backend/`](backend) | Spring Boot + Postgres authoring API, used only to author/manage the source content. Not part of the shipped app. |
| [`pipeline/`](pipeline) | Node.js export script: reads the authoring database, compresses large fields with zstd, writes `records.jsonl`. |
| [`docs/`](docs) | Architecture and local setup notes. |

## How the dataset gets into the app

```
Postgres (authoring)
        │  pipeline/index.js
        ▼
records.jsonl  (large fields pre-compressed with zstd)
        │  app/tool/import_dataset.dart
        ▼
dataset.isar
        │  bundled as a Flutter asset
        ▼
Shipped app  →  first launch copies it into place  →  opened directly
```

The app has **no in-app data-import feature** — the dataset is entirely pre-packaged at build time. On first launch it copies the bundled `.isar` file into the app's local storage; after that it just opens it. Records are queried and displayed straight from Isar, and a record's compressed payload is only decompressed (off the UI thread) when that specific record is opened.

See [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) for the full design and [`docs/SETUP.md`](docs/SETUP.md) for local setup instructions.

## Core constraints

- Fully offline — no runtime dependency on network connectivity for core features.
- Pre-packaged dataset, target size ~500–600 MB.
- Large fields stored compressed with zstd; decompressed only when needed, never in bulk.
- Isar for local storage, with indexes on the fields that need to be queried directly.
