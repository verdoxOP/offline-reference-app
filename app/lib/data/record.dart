import 'package:isar_community/isar.dart';

part 'record.g.dart';

@collection
class Record {
  Id id = Isar.autoIncrement;

  @Index()
  String? title;

  @Index()
  String? category;

  double? lat;
  double? lng;

  List<String>? imageUrls;

  /// Zstd-compressed payload for large fields. Decompress on demand via
  /// DecompressService — never eagerly, and never on the UI thread.
  List<byte>? compressedPayload;
}
