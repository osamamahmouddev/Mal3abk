import 'package:flutter/material.dart';

import 'deep_link_resolver.dart';
import 'routes.dart';

/// Root navigator access for code that runs outside the widget tree, such as
/// the network layer ending an expired session or a tapped push.
class AppNavigator {
  const AppNavigator._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static DeepLinkTarget? _pendingLink;
  static bool _shellReady = false;

  /// True while the signed-in shell is on screen.
  static final ValueNotifier<bool> shellShown = ValueNotifier<bool>(false);

  /// The link waiting for the signed-in shell, if any.
  static DeepLinkTarget? get pendingLink => _pendingLink;

  static void openLogin() {
    onShellClosed();
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (_) => false,
    );
  }

  /// Opens the screen of a tapped push. Until the signed-in shell is shown
  /// (cold start, splash, app lock, login) the link waits and opens as soon
  /// as [onShellReady] runs.
  static void openDeepLink(DeepLinkTarget target) {
    final navigator = navigatorKey.currentState;
    if (!_shellReady || navigator == null) {
      _pendingLink = target;
      return;
    }
    navigator.pushNamed(target.route, arguments: target.arguments);
  }

  static void onShellReady() {
    _shellReady = true;
    shellShown.value = true;
    final pending = _pendingLink;
    _pendingLink = null;
    if (pending != null) openDeepLink(pending);
  }

  static void onShellClosed() {
    _shellReady = false;
    shellShown.value = false;
  }

  @visibleForTesting
  static void reset() {
    _pendingLink = null;
    _shellReady = false;
    shellShown.value = false;
  }
}
