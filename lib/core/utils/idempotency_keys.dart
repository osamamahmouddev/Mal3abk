import 'dart:math';

class UuidV4 {
  const UuidV4._();

  static String generate() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}

/// `Idempotency-Key`s per logical operation: retrying the same operation
/// after a timeout reuses its key, so the server never applies it twice. A
/// key is dropped once the operation succeeds.
class IdempotencyKeys {
  final Map<String, String> _keys = {};

  String keyFor(String operation) =>
      _keys.putIfAbsent(operation, UuidV4.generate);

  void complete(String operation) => _keys.remove(operation);
}
