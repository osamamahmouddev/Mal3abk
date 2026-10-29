import 'dart:math';

import 'secure_storage.dart';

/// Stable per-install device id, sent as `X-Device-Id`. It is not a secret,
/// so it lives in shared preferences and is reset when the app is reinstalled.
class DeviceIdStorage {
  DeviceIdStorage();

  static const String _deviceIdKey = 'device_id';

  String? _deviceId;

  Future<String> readDeviceId() async {
    if (_deviceId != null) return _deviceId!;

    final storedId = await SharedPrefHelper.getString(_deviceIdKey);
    if (storedId.isNotEmpty) return _deviceId = storedId;

    final newId = _generateUuidV4();
    await SharedPrefHelper.setData(_deviceIdKey, newId);
    return _deviceId = newId;
  }

  static String _generateUuidV4() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
