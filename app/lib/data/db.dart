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

  Future<List<Record>> getAllRecords({required String language}) =>
      isar.records.filter().languageEqualTo(language).findAll();

  /// Row count for the category chips — an indexed count, not a full read,
  /// so it stays cheap regardless of dataset size.
  Future<int> countRecords({required String language, String? category}) {
    if (category == null) {
      return isar.records.filter().languageEqualTo(language).count();
    }
    return isar.records
        .filter()
        .languageEqualTo(language)
        .and()
        .categoryEqualTo(category)
        .count();
  }

  /// Combines the category filter chips with the search box: [category] is
  /// the exact category string for the active [language] (see
  /// `categoryLabelForKey`), or `null` for "all categories". Written as
  /// independent query chains per branch (rather than reassigning a shared
  /// builder) since Isar's QueryBuilder carries its filter-group state in
  /// its generic type, which a conditionally-built chain can't express.
  Future<List<Record>> filterRecords(
    String query, {
    required String language,
    String? category,
  }) {
    final trimmed = query.trim();
    if (category == null && trimmed.isEmpty) {
      return isar.records.filter().languageEqualTo(language).findAll();
    }
    if (category == null) {
      return isar.records
          .filter()
          .languageEqualTo(language)
          .and()
          .group((q) => q
              .titleContains(trimmed, caseSensitive: false)
              .or()
              .categoryContains(trimmed, caseSensitive: false))
          .findAll();
    }
    if (trimmed.isEmpty) {
      return isar.records
          .filter()
          .languageEqualTo(language)
          .and()
          .categoryEqualTo(category)
          .findAll();
    }
    return isar.records
        .filter()
        .languageEqualTo(language)
        .and()
        .categoryEqualTo(category)
        .and()
        .group((q) => q
            .titleContains(trimmed, caseSensitive: false)
            .or()
            .categoryContains(trimmed, caseSensitive: false))
        .findAll();
  }
}
