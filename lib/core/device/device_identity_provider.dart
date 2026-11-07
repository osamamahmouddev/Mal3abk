import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// How this phone introduces itself to the server, for the player's list of
/// signed-in devices.
class DeviceIdentity {
  const DeviceIdentity({required this.name, required this.userAgent});

  /// Make and model, e.g. "Samsung SM-S911B" or "iPhone 15 Pro". Never the
  /// name the owner gave the phone, which often contains their own name.
  final String? name;

  /// e.g. "Malabak/1.0.0 (Android 14)".
  final String userAgent;
}

/// Reads the device once and keeps the result for every request.
class DeviceIdentityProvider {
  DeviceIdentityProvider({
    DeviceInfoPlugin? deviceInfo,
    Future<PackageInfo> Function()? packageInfo,
  }) : _deviceInfo = deviceInfo ?? DeviceInfoPlugin(),
       _packageInfo = packageInfo ?? PackageInfo.fromPlatform;

  static const int _maxNameLength = 100;
  static const String _appName = 'Malabak';

  final DeviceInfoPlugin _deviceInfo;
  final Future<PackageInfo> Function() _packageInfo;
  Future<DeviceIdentity>? _identity;

  Future<DeviceIdentity> read() => _identity ??= _load();

  Future<DeviceIdentity> _load() async {
    var version = '0.0.0';
    String? name;
    var os = defaultTargetPlatform.name;
    try {
      version = (await _packageInfo()).version;
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        name = makeAndModel(info.manufacturer, info.model);
        os = 'Android ${info.version.release}';
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        name = info.modelName;
        os = 'iOS ${info.systemVersion}';
      }
    } on Object {
      // A device that cannot describe itself still gets a readable agent.
    }
    return DeviceIdentity(
      name: headerSafe(name, _maxNameLength),
      userAgent: headerSafe('$_appName/$version ($os)', 200)!,
    );
  }

  /// "samsung" + "SM-S911B" → "Samsung SM-S911B"; "Google" + "Google Pixel 8"
  /// → "Google Pixel 8".
  @visibleForTesting
  static String makeAndModel(String manufacturer, String model) {
    final make = manufacturer.trim();
    final trimmedModel = model.trim();
    if (make.isEmpty) return trimmedModel;
    if (trimmedModel.toLowerCase().startsWith(make.toLowerCase())) {
      return trimmedModel;
    }
    final capitalized = make[0].toUpperCase() + make.substring(1);
    return '$capitalized $trimmedModel';
  }

  /// Header values must be printable ASCII; anything else is dropped.
  @visibleForTesting
  static String? headerSafe(String? value, int maxLength) {
    if (value == null) return null;
    final cleaned = value
        .replaceAll(RegExp(r'[^\x20-\x7E]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    if (cleaned.isEmpty) return null;
    return cleaned.length > maxLength
        ? cleaned.substring(0, maxLength)
        : cleaned;
  }
}
