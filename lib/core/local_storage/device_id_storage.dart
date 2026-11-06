import '../utils/idempotency_keys.dart';
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

    final newId = UuidV4.generate();
    await SharedPrefHelper.setData(_deviceIdKey, newId);
    return _deviceId = newId;
  }
}
