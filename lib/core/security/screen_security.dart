import 'package:flutter/services.dart';

/// Prevents screenshots, screen recordings, and task switcher thumbnail leaks
/// on sensitive screens (e.g. proof upload, deposit details, session security)
/// via Android FLAG_SECURE and iOS privacy controls.
class ScreenSecurity {
  const ScreenSecurity({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('com.example.mal3abk/security');

  final MethodChannel _channel;

  /// Enables or disables screen capture protection for the current window.
  Future<bool> setSecure(bool secure) async {
    try {
      final result = await _channel.invokeMethod<bool>('setSecure', {
        'secure': secure,
      });
      return result ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      // Graceful fallback in environments without the native channel (e.g. tests, web).
      return false;
    }
  }
}
