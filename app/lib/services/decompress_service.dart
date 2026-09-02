import 'dart:isolate';
import 'dart:typed_data';

import '../native/zstd_bindings.dart';

/// Decompresses zstd-compressed record payloads.
///
/// Runs off the UI thread (a fresh isolate per call) so a large blob never
/// blocks Flutter's rendering — see the CLAUDE.md decompression rules.
class DecompressService {
  /// Accepts `List<int>` since that's what Isar hands back for a `List<byte>`
  /// field — callers shouldn't have to convert it themselves.
  Future<Uint8List> decompress(List<int> compressed) {
    final bytes = compressed is Uint8List ? compressed : Uint8List.fromList(compressed);
    return Isolate.run(() => ZstdBindings().decompressBytes(bytes));
  }
}
