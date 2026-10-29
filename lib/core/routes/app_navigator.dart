import 'package:flutter/material.dart';

import 'routes.dart';

/// Root navigator access for code that runs outside the widget tree, such as
/// the network layer ending an expired session.
class AppNavigator {
  const AppNavigator._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void openLogin() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (_) => false,
    );
  }
}
