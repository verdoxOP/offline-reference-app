// Stand-in for pipeline/index.js while there's no populated authoring
// Postgres to export from: reads the checked-in bilingual source content at
// pipeline/seed/content.json, compresses each language's body with zstd,
// and writes pipeline/dist/bundle-v0.0.1/records.jsonl in the exact shape
// pipeline/index.js produces. Once the authoring backend has real content,
// run the real pipeline instead — this script becomes unnecessary.
//
// Run before tool/import_dataset.dart:
//   dart run tool/generate_seed_dataset.dart
//   dart run tool/import_dataset.dart

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:offline_reference_app/native/zstd_bindings.dart';

Future<void> main() async {
  final contentFile = File('../pipeline/seed/content.json');
  final content = jsonDecode(contentFile.readAsStringSync()) as Map<String, dynamic>;
  final topics = (content['topics'] as List).cast<Map<String, dynamic>>();

  final bindings = ZstdBindings();
  final lines = <String>[];
  var id = 1;

  for (final topic in topics) {
    final topicId = topic['topicId'] as String;
    final category = topic['category'] as Map<String, dynamic>;
    final title = topic['title'] as Map<String, dynamic>;
    final body = topic['body'] as Map<String, dynamic>;

    // The Kaart topics point at the real Tilburg map instead of a per-topic photo.
    const kaartTopics = {'noodsteunpunten', 'watertappunten'};
    final imagePath = kaartTopics.contains(topicId)
        ? 'assets/images/kaart_tilburg.jpg'
        : 'assets/images/$topicId.jpg';
    final imageUrls = File(imagePath).existsSync() ? [imagePath] : <String>[];

    for (final language in ['nl', 'en']) {
      final compressed =
          bindings.compressBytes(Uint8List.fromList(utf8.encode(body[language] as String)));
      lines.add(jsonEncode({
        'id': id++,
        'topicId': topicId,
        'language': language,
        'title': title[language],
        'category': category[language],
        'lat': null,
        'lng': null,
        'imageUrls': imageUrls,
        'compressedPayload': base64Encode(compressed),
      }));
    }
  }

  final outDir = Directory('../pipeline/dist/bundle-v0.0.1');
  outDir.createSync(recursive: true);
  final outFile = File('${outDir.path}/records.jsonl');
  outFile.writeAsStringSync('${lines.join('\n')}\n');
  print('Wrote ${lines.length} records (${topics.length} topics x 2 languages) to ${outFile.path}');
}
