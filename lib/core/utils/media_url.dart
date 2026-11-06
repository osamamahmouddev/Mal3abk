/// Media paths from the API may be relative (`/api/v1/media/...`); images
/// need an absolute URL.
class MediaUrl {
  const MediaUrl._();

  static String? resolve(String? path, {required String baseUrl}) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return path.startsWith('/') ? '$base$path' : '$base/$path';
  }
}
