import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:isar_community/isar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'record.dart';

export 'record.dart';

class AppDatabase {
  AppDatabase._(this.isar);

  final Isar isar;

  static const _instanceName = 'dataset';
  static const _bundledAssetPath = 'assets/data/dataset.isar';

  /// Opens the pre-packaged dataset shipped with the app. On first launch
  /// the bundled Isar file is copied into the app's documents directory;
  /// after that it's opened in place. There is no in-app data-import path —
  /// the dataset only ever comes from the build (see tool/import_dataset.dart).
  static Future<AppDatabase> open() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(docsDir.path, '$_instanceName.isar'));

    if (!await dbFile.exists()) {
      await _copyBundledDataset(dbFile);
    }

    final isar = await Isar.open(
      [RecordSchema],
      directory: docsDir.path,
      name: _instanceName,
    );
    return AppDatabase._(isar);
  }

  static Future<void> _copyBundledDataset(File target) async {
    final bytes = await rootBundle.load(_bundledAssetPath);
    await target.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      flush: true,
    );
  }

  Future<List<Record>> getAllRecords() => isar.records.where().findAll();

  /// Matches records whose title or category contains [query]
  /// (case-insensitive). Only the matching rows are read — never the whole
  /// dataset, and never anything's compressedPayload.
  Future<List<Record>> searchRecords(String query) {
    if (query.isEmpty) return getAllRecords();
    return isar.records
        .filter()
        .titleContains(query, caseSensitive: false)
        .or()
        .categoryContains(query, caseSensitive: false)
        .findAll();
  }
}
