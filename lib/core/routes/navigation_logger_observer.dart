import 'package:flutter/material.dart';

import '../utils/app_logger.dart';

class NavigationLoggerObserver extends NavigatorObserver {
  NavigationLoggerObserver({this.onNavigationChanged});

  final VoidCallback? onNavigationChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    AppLogger.d(
      'Navigated to: ${route.settings.name} from: ${previousRoute?.settings.name}',
    );
    onNavigationChanged?.call();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    AppLogger.d(
      'Popped from: ${route.settings.name} to: ${previousRoute?.settings.name}',
    );
    onNavigationChanged?.call();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    onNavigationChanged?.call();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    onNavigationChanged?.call();
  }
}
