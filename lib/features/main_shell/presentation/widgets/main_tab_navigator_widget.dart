import 'package:flutter/material.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/routes/navigation_logger_observer.dart';
import '../../../../core/routes/tab_root_observer.dart';

/// Independent navigation stack for one bottom-nav tab.
class MainTabNavigatorWidget extends StatelessWidget {
  const MainTabNavigatorWidget({
    required this.navigatorKey,
    required this.initialRoute,
    required this.observer,
    required this.rootObserver,
    required this.isActive,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;
  final NavigationLoggerObserver observer;
  final TabRootObserver rootObserver;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return TickerMode(
      enabled: isActive,
      child: HeroControllerScope.none(
        child: Navigator(
          key: navigatorKey,
          initialRoute: initialRoute,
          // Build only the tab route; the default splits '/home' into
          // ['/', '/home'] and would stack the splash screen underneath.
          onGenerateInitialRoutes: (_, route) => [
            AppRouter.onGenerateRoute(RouteSettings(name: route)),
          ],
          onGenerateRoute: AppRouter.onGenerateRoute,
          observers: [observer, rootObserver],
        ),
      ),
    );
  }
}
