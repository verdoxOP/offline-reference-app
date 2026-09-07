# Offline Reference App

A fully offline-first reference app that ships with a large (~500–600 MB) pre-packaged dataset. No network connectivity is required for any core functionality — the app works in airplane mode.

Large fields are compressed with **Zstandard (zstd)** and stored in **Isar**, decompressed on demand only when a record is actually opened — never the whole dataset at once.

## Features

- **Search** — indexed Isar query over title/category, never decompresses unrelated records.
- **Dutch/English** — every topic has both languages; an NL/EN toggle in the app bar switches UI strings and which language is queried.
- **Real content** — 17 emergency-preparedness topics (Basis/Nood/Kaart/FAQ), each with real, openly-licensed photos (credited in [`app/assets/images/ATTRIBUTION.md`](app/assets/images/ATTRIBUTION.md)).
- **Kaart** — a real map of Tilburg (actual hospitals, police stations, fire stations, and public water taps, sourced from OpenStreetMap and self-rendered — no live tiles) with icon markers and pan/pinch-zoom, fully offline.

## Structure

This is a multi-root workspace:

| Folder | What it is |
|---|---|
| [`app/`](app) | The Flutter app. Isar for storage, zstd (via Dart FFI) for on-demand decompression. This is the only thing that ships to users. |
| [`backend/`](backend) | Spring Boot + Postgres authoring API, used only to author/manage the source content. Not part of the shipped app. Not yet populated with real content. |
| [`pipeline/`](pipeline) | Node.js export script: reads the authoring database, compresses large fields with zstd, writes `records.jsonl`. Until the backend is populated, [`pipeline/seed/content.json`](pipeline/seed/content.json) (the real bilingual content, checked into git) stands in for it. |
| [`docs/`](docs) | Architecture and local setup notes. |

## How the dataset gets into the app

```
Postgres (authoring)  ─┐
                        │  pipeline/index.js
pipeline/seed/content.json ─┤  (stand-in until the backend is populated)
                        │  app/tool/generate_seed_dataset.dart
                        ▼
records.jsonl  (large fields pre-compressed with zstd, per language)
        │  app/tool/import_dataset.dart
        ▼
dataset.isar
        │  bundled as a Flutter asset
        ▼
Shipped app  →  first launch copies it into place  →  opened directly
```

The app has **no in-app data-import feature** — the dataset is entirely pre-packaged at build time. On first launch it copies the bundled `.isar` file into the app's local storage; after that it just opens it. Records are queried and displayed straight from Isar, filtered by the selected language, and a record's compressed payload is only decompressed (off the UI thread) when that specific record is opened.

See [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) for the full design and [`docs/SETUP.md`](docs/SETUP.md) for local setup instructions.

## Core constraints

- Fully offline — no runtime dependency on network connectivity for core features. The Tilburg map is a self-rendered image, not live map tiles.
- Pre-packaged dataset, target size ~500–600 MB.
- Large fields stored compressed with zstd; decompressed only when needed, never in bulk.
- Isar for local storage, with indexes on the fields that need to be queried directly.
