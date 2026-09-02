const { Client } = require('pg');
const fs = require('fs');
const path = require('path');
const zstd = require('zstd-codec').ZstdCodec;

// Exports records as newline-delimited JSON matching the app's Isar `Record`
// collection (see app/lib/data/db.dart). Consumed by
// app/tool/import_dataset.dart, which builds the .isar file shipped with the
// app — this script never touches Isar directly.
async function main() {
  const outDir = path.join(__dirname, 'dist', 'bundle-v0.0.1');
  fs.mkdirSync(outDir, { recursive: true });

  const client = new Client({
    host: 'localhost',
    port: 5432,
    user: 'appuser',
    password: 'secret',
    database: 'appdb'
  });
  await client.connect();

  const records = (await client.query('SELECT id, topic_id, language, title, category, description, lat, lng, image_urls FROM records')).rows || [];

  await new Promise((resolve, reject) => {
    zstd.run((zstdInstance) => {
      try {
        const compress = (text) => {
          const input = Uint8Array.from(Buffer.from(text || '', 'utf8'));
          return Buffer.from(zstdInstance.compress(input));
        };

        const outPath = path.join(outDir, 'records.jsonl');
        const lines = records.map(r => JSON.stringify({
          id: r.id,
          topicId: r.topic_id,
          language: r.language,
          title: r.title,
          category: r.category,
          lat: r.lat,
          lng: r.lng,
          imageUrls: r.image_urls,
          // description is the large field: compressed for storage, decompressed
          // on demand on-device. Not shipped in plaintext to avoid storing it twice.
          compressedPayload: compress(r.description).toString('base64'),
        }));
        fs.writeFileSync(outPath, lines.join('\n') + (lines.length ? '\n' : ''));

        console.log(`Wrote ${records.length} records to`, outPath);
        resolve();
      } catch (err) {
        reject(err);
      }
    });
  });

  await client.end();
}

main().catch(err => { console.error(err); process.exit(1); });
