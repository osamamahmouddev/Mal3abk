import 'package:flutter/material.dart';

import '../utils/app_logger.dart';

class NavigationLoggerObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    AppLogger.d(
      'Navigated to: ${route.settings.name} from: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    AppLogger.d(
      'Popped from: ${route.settings.name} to: ${previousRoute?.settings.name}',
    );
  }
}
