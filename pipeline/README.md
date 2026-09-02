# Pipeline

Exports records from the Postgres authoring DB to `dist/bundle-v0.0.1/records.jsonl`, compressing each record's large text field (per language) with zstd. That file is consumed by `app/tool/import_dataset.dart`, which builds the `.isar` database the Flutter app ships with.

The authoring backend isn't populated yet, so there's currently nothing to export. Until it is, `seed/content.json` (bilingual nl/en source content, checked into git) plus `app/tool/generate_seed_dataset.dart` stand in for this script — see `docs/SETUP.md`.

Install:

```bash
cd pipeline
npm install
```

Run:

```bash
node index.js
```

Tippecanoe example (requires separate install):

```bash
# tippecanoe -o tiles.mbtiles -z14 -Z0 --drop-densest-as-needed input.geojson
```
