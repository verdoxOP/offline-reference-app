# Pipeline

Exports records from the Postgres authoring DB to `dist/bundle-v0.0.1/records.jsonl`, compressing each record's large text field with zstd. That file is consumed by `app/tool/import_dataset.dart`, which builds the `.isar` database the Flutter app ships with.

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
