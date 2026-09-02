// Dart FFI bindings to the system zstd shared library (libzstd).
// Only the whole-buffer compress/decompress API is bound — sufficient for
// per-record blobs, which is the compression boundary this app uses.

import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

typedef _ZstdCompressBoundNative = IntPtr Function(IntPtr srcSize);
typedef _ZstdCompressBoundDart = int Function(int srcSize);

typedef _ZstdCompressNative = IntPtr Function(Pointer<Uint8> dst,
    IntPtr dstCapacity, Pointer<Uint8> src, IntPtr srcSize, Int32 level);
typedef _ZstdCompressDart = int Function(
    Pointer<Uint8> dst, int dstCapacity, Pointer<Uint8> src, int srcSize, int level);

typedef _ZstdDecompressNative = IntPtr Function(
    Pointer<Uint8> dst, IntPtr dstCapacity, Pointer<Uint8> src, IntPtr srcSize);
typedef _ZstdDecompressDart = int Function(
    Pointer<Uint8> dst, int dstCapacity, Pointer<Uint8> src, int srcSize);

typedef _ZstdIsErrorNative = Uint32 Function(IntPtr code);
typedef _ZstdIsErrorDart = int Function(int code);

typedef _ZstdGetErrorNameNative = Pointer<Utf8> Function(IntPtr code);
typedef _ZstdGetErrorNameDart = Pointer<Utf8> Function(int code);

typedef _ZstdGetFrameContentSizeNative = Int64 Function(
    Pointer<Uint8> src, IntPtr srcSize);
typedef _ZstdGetFrameContentSizeDart = int Function(Pointer<Uint8> src, int srcSize);

/// Thin wrapper around libzstd's whole-buffer compress/decompress API.
///
/// Safe to construct repeatedly (e.g. once per isolate) — `DynamicLibrary.open`
/// is cheap on repeat calls for an already-loaded library.
class ZstdBindings {
  factory ZstdBindings() => _instance ??= ZstdBindings._(_openLibrary());

  ZstdBindings._(DynamicLibrary lib)
      : compressBound = lib.lookupFunction<_ZstdCompressBoundNative,
            _ZstdCompressBoundDart>('ZSTD_compressBound'),
        compress = lib.lookupFunction<_ZstdCompressNative, _ZstdCompressDart>(
            'ZSTD_compress'),
        decompress = lib
            .lookupFunction<_ZstdDecompressNative, _ZstdDecompressDart>(
                'ZSTD_decompress'),
        isError = lib
            .lookupFunction<_ZstdIsErrorNative, _ZstdIsErrorDart>('ZSTD_isError'),
        getErrorName = lib.lookupFunction<_ZstdGetErrorNameNative,
            _ZstdGetErrorNameDart>('ZSTD_getErrorName'),
        getFrameContentSize = lib.lookupFunction<
            _ZstdGetFrameContentSizeNative,
            _ZstdGetFrameContentSizeDart>('ZSTD_getFrameContentSize');

  static ZstdBindings? _instance;

  final _ZstdCompressBoundDart compressBound;
  final _ZstdCompressDart compress;
  final _ZstdDecompressDart decompress;
  final _ZstdIsErrorDart isError;
  final _ZstdGetErrorNameDart getErrorName;
  final _ZstdGetFrameContentSizeDart getFrameContentSize;

  static DynamicLibrary _openLibrary() {
    if (Platform.isAndroid) return DynamicLibrary.open('libzstd.so');
    if (Platform.isLinux) return DynamicLibrary.open('libzstd.so.1');
    if (Platform.isMacOS || Platform.isIOS) {
      return DynamicLibrary.open('libzstd.dylib');
    }
    if (Platform.isWindows) return DynamicLibrary.open('zstd.dll');
    throw UnsupportedError('Platform not supported: ${Platform.operatingSystem}');
  }

  /// Decompresses a single zstd frame that was written with its content size
  /// embedded (the default for `ZSTD_compress`).
  Uint8List decompressBytes(Uint8List compressedBytes) {
    final srcPtr = malloc<Uint8>(compressedBytes.length);
    srcPtr.asTypedList(compressedBytes.length).setAll(0, compressedBytes);
    try {
      final contentSize = getFrameContentSize(srcPtr, compressedBytes.length);
      if (contentSize < 0) {
        throw StateError(
            'zstd: could not determine decompressed size (unknown or invalid frame)');
      }

      final dstPtr = malloc<Uint8>(contentSize);
      try {
        final result = decompress(dstPtr, contentSize, srcPtr, compressedBytes.length);
        if (isError(result) != 0) {
          throw StateError(
              'zstd decompression failed: ${getErrorName(result).toDartString()}');
        }
        return Uint8List.fromList(dstPtr.asTypedList(result));
      } finally {
        malloc.free(dstPtr);
      }
    } finally {
      malloc.free(srcPtr);
    }
  }

  /// Compresses [bytes] at the given zstd [level]. Used by the offline data
  /// pipeline / tooling, not by the app's read path.
  Uint8List compressBytes(Uint8List bytes, {int level = 3}) {
    final srcPtr = malloc<Uint8>(bytes.length);
    srcPtr.asTypedList(bytes.length).setAll(0, bytes);
    try {
      final bound = compressBound(bytes.length);
      final dstPtr = malloc<Uint8>(bound);
      try {
        final result = compress(dstPtr, bound, srcPtr, bytes.length, level);
        if (isError(result) != 0) {
          throw StateError(
              'zstd compression failed: ${getErrorName(result).toDartString()}');
        }
        return Uint8List.fromList(dstPtr.asTypedList(result));
      } finally {
        malloc.free(dstPtr);
      }
    } finally {
      malloc.free(srcPtr);
    }
  }
}
