/// Team invite links: `https://<api host>/join/<CODE>` to share, and
/// `malabak://app/join/<CODE>` from the web page that hands the code to the
/// app. Both reach the app as the route `/join/<CODE>`.
///
/// A link only ever opens the join screen with the code filled in: the player
/// sees the team and taps join themselves, signed in. Anything that is not
/// exactly an invite link (another host or scheme, extra path, a code of the
/// wrong shape) is ignored, and query strings and fragments are never read.
class InviteLink {
  const InviteLink._();

  static const String appScheme = 'malabak';
  static const String appHost = 'app';
  static const String segment = 'join';
  static const int codeLength = 6;

  /// The invite-code alphabet: no 0/O or 1/I, so a code read aloud is not
  /// mistyped.
  static final RegExp _code = RegExp(r'^[A-HJ-NP-Z2-9]{6}$');

  /// [raw] trimmed and upper-cased when it has the invite-code shape, else
  /// null.
  static String? normalize(String? raw) {
    final code = raw?.trim().toUpperCase();
    return code != null && _code.hasMatch(code) ? code : null;
  }

  /// The code of an invite link, or null when [location] is not one.
  ///
  /// [location] is a route (`/join/ABC234`) or a full link. Full web links
  /// must be on one of [webHosts]; app links must be `malabak://app/...`.
  static String? codeFrom(String? location, {Set<String> webHosts = const {}}) {
    if (location == null || location.isEmpty) return null;
    final uri = Uri.tryParse(location);
    if (uri == null || uri.userInfo.isNotEmpty) return null;

    if (uri.hasScheme) {
      final scheme = uri.scheme.toLowerCase();
      final host = uri.host.toLowerCase();
      final trusted = switch (scheme) {
        appScheme => host == appHost,
        'https' || 'http' => webHosts.contains(host),
        _ => false,
      };
      if (!trusted) return null;
    } else if (uri.hasAuthority) {
      return null;
    }

    final parts = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (parts.length != 2 || parts.first != segment) return null;
    return normalize(parts.last);
  }

  /// The link to share for [code] on the API host of [baseUrl].
  static String share(String baseUrl, String code) {
    final base = Uri.parse(baseUrl);
    return Uri(
      scheme: base.scheme,
      host: base.host,
      port: base.hasPort ? base.port : null,
      path: '/$segment/$code',
    ).toString();
  }
}
