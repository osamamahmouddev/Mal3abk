import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  const SharedPrefHelper._();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static Future<void> removeData(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  static Future<void> clearAllData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<void> setData(String key, Object value) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (value is String) {
      await sharedPreferences.setString(key, value);
      return;
    }

    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return;
    }

    if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return;
    }

    if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return;
    }

    throw UnsupportedError(
      'Unsupported SharedPreferences type: ${value.runtimeType}',
    );
  }

  static Future<bool> getBool(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  static Future<double> getDouble(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  static Future<int> getInt(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  static Future<String> getString(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  static Future<void> setSecuredString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    return _secureStorage.read(key: key).then((value) => value ?? '');
  }

  static Future<void> removeSecuredData(String key) async {
    await _secureStorage.delete(key: key);
  }

  static Future<void> clearAllSecuredData() async {
    await _secureStorage.deleteAll();
  }
}
