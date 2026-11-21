import 'package:flutter/widgets.dart';

import 'app_navigator.dart';
import 'deep_link_resolver.dart';
import 'invite_link.dart';
import 'routes.dart';

/// Opens team invite links that arrive while the app is running. Registered
/// before the app's own route handling, it takes only invite links and hands
/// every other link on unchanged.
class InviteLinkObserver with WidgetsBindingObserver {
  InviteLinkObserver({required this.webHosts});

  /// Hosts whose `/join/<CODE>` web links are trusted (the API host).
  final Set<String> webHosts;

  /// The join screen for an invite link, or null for any other location.
  static DeepLinkTarget? targetFor(
    String? location, {
    required Set<String> webHosts,
  }) {
    final code = InviteLink.codeFrom(location, webHosts: webHosts);
    if (code != null) {
      return DeepLinkTarget(route: AppRoutes.joinTeamByCode, arguments: code);
    }
    return DeepLinkResolver.resolve(location);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    final target = targetFor(
      routeInformation.uri.toString(),
      webHosts: webHosts,
    );
    if (target == null) return Future.value(false);
    // Waits for sign-in and the app lock when the shell is not shown yet.
    AppNavigator.openDeepLink(target);
    return Future.value(true);
  }
}
