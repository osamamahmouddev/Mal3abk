import '../config/env_config.dart';
import '../di/service_locator.dart';

/// Media paths from the API may be relative (`/api/v1/media/...`); images
/// need an absolute URL.
class MediaUrl {
  const MediaUrl._();

  static String? resolve(String? path, {String? baseUrl}) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    final effectiveBase = baseUrl ??
        (sl.isRegistered<EnvConfig>() ? sl<EnvConfig>().baseUrl : '');
    if (effectiveBase.isEmpty) return path;
    final base = effectiveBase.endsWith('/')
        ? effectiveBase.substring(0, effectiveBase.length - 1)
        : effectiveBase;
    return path.startsWith('/') ? '$base$path' : '$base/$path';
  }
}
