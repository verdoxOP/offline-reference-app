import 'dart:isolate';
import 'dart:typed_data';

import '../native/zstd_bindings.dart';

/// Decompresses zstd-compressed record payloads.
///
/// Runs off the UI thread — in a fresh isolate — only above
/// [_isolateThresholdBytes]; see the CLAUDE.md decompression rules.
class DecompressService {
  /// Below this compressed size, `Isolate.run`'s spawn cost — plus reopening
  /// and re-resolving the zstd dynamic library from scratch in the fresh
  /// isolate, since `ZstdBindings`' singleton doesn't carry across isolates —
  /// costs far more than the decompression itself. Text this small (roughly
  /// up to a long article, given zstd's ~3-4x ratio on prose) decompresses
  /// in well under a millisecond, so doing it inline is both faster and
  /// still nowhere near enough to affect UI responsiveness.
  static const _isolateThresholdBytes = 32 * 1024;

  /// Accepts `List<int>` since that's what Isar hands back for a `List<byte>`
  /// field — callers shouldn't have to convert it themselves.
  Future<Uint8List> decompress(List<int> compressed) {
    final bytes = compressed is Uint8List ? compressed : Uint8List.fromList(compressed);
    if (bytes.length < _isolateThresholdBytes) {
      return Future.value(ZstdBindings().decompressBytes(bytes));
    }
    return Isolate.run(() => ZstdBindings().decompressBytes(bytes));
  }
}
