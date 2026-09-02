// Build-time tool: reads the pipeline's records.jsonl (see
// pipeline/index.js) and writes the .isar database that gets bundled into
// the app as assets/data/dataset.isar (see pubspec.yaml `flutter: assets:`
// and AppDatabase.open() in lib/data/db.dart, which copies it into place on
// first launch).
//
// This never runs inside the shipped app — the app has no data-import
// feature. Run it whenever the pipeline produces a new dataset:
//
//   dart run tool/import_dataset.dart \
//     --input ../pipeline/dist/bundle-v0.0.1/records.jsonl \
//     --output assets/data

import 'dart:convert';
import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:offline_reference_app/data/record.dart';

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  final inputFile = File(options['input']!);
  final outputDir = Directory(options['output']!);

  if (!inputFile.existsSync()) {
    stderr.writeln('Input file not found: ${inputFile.path}');
    exitCode = 1;
    return;
  }
  outputDir.createSync(recursive: true);

  final records = inputFile
      .readAsLinesSync()
      .where((line) => line.trim().isNotEmpty)
      .map(_recordFromJsonLine)
      .toList();

  await Isar.initializeIsarCore(download: true);

  final datasetFile = File('${outputDir.path}/dataset.isar');
  if (datasetFile.existsSync()) {
    datasetFile.deleteSync();
  }

  final isar = await Isar.open(
    [RecordSchema],
    directory: outputDir.path,
    name: 'dataset',
  );
  await isar.writeTxn(() => isar.records.putAll(records));
  await isar.close();

  print('Imported ${records.length} records into ${datasetFile.path}');
}

Record _recordFromJsonLine(String line) {
  final json = jsonDecode(line) as Map<String, dynamic>;
  return Record()
    ..id = json['id'] as int
    ..topicId = json['topicId'] as String?
    ..language = json['language'] as String?
    ..title = json['title'] as String?
    ..category = json['category'] as String?
    ..lat = (json['lat'] as num?)?.toDouble()
    ..lng = (json['lng'] as num?)?.toDouble()
    ..imageUrls = (json['imageUrls'] as List?)?.cast<String>()
    ..compressedPayload = json['compressedPayload'] != null
        ? base64Decode(json['compressedPayload'] as String)
        : null;
}

Map<String, String> _parseArgs(List<String> args) {
  final defaults = {
    'input': '../pipeline/dist/bundle-v0.0.1/records.jsonl',
    'output': 'assets/data',
  };
  for (var i = 0; i < args.length - 1; i++) {
    if (args[i] == '--input') defaults['input'] = args[i + 1];
    if (args[i] == '--output') defaults['output'] = args[i + 1];
  }
  return defaults;
}
