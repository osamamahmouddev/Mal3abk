import 'routes.dart';

/// A screen to open for a `malabak://` link sent by the server.
class DeepLinkTarget {
  const DeepLinkTarget({required this.route, this.arguments});

  final String route;
  final Object? arguments;
}

class DeepLinkResolver {
  const DeepLinkResolver._();

  static const String scheme = 'malabak';

  /// Unknown, foreign-scheme or malformed links resolve to null.
  static DeepLinkTarget? resolve(String? link) {
    if (link == null || link.isEmpty) return null;
    final uri = Uri.tryParse(link);
    if (uri == null || uri.scheme != scheme) return null;

    final id = uri.pathSegments.isEmpty ? '' : uri.pathSegments.first;
    final hasId = uri.pathSegments.length == 1 && id.isNotEmpty;
    return switch (uri.host) {
      'booking' when hasId && id != 'create' => DeepLinkTarget(
        route: AppRoutes.bookingDetails,
        arguments: id,
      ),
      'venue' when hasId => DeepLinkTarget(
        route: AppRoutes.venueProfile,
        arguments: id,
      ),
      'team' when hasId => DeepLinkTarget(
        route: AppRoutes.teamProfile,
        arguments: id,
      ),
      'match' when hasId => DeepLinkTarget(
        route: AppRoutes.matchDetails,
        arguments: id,
      ),
      'challenge' when hasId => DeepLinkTarget(
        route: AppRoutes.challengeDetails,
        arguments: id,
      ),
      'settings' => const DeepLinkTarget(route: AppRoutes.settings),
      _ => null,
    };
  }
}
