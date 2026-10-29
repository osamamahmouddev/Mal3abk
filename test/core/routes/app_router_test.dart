import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:mal3abk/core/routes/app_router.dart';
import 'package:mal3abk/core/routes/routes.dart';

void main() {
  group('AppRouter.onGenerateInitialRoutes', () {
    test('opens only the recovery screen for a recovery deep link', () {
      final routes = AppRouter.onGenerateInitialRoutes(
        '/recover-phone?token=abc',
      );

      expect(routes, hasLength(1));
      expect(routes.single.settings.name, AppRoutes.recoverPhone);
    });

    test('starts at the splash screen for a normal launch', () {
      final routes = AppRouter.onGenerateInitialRoutes(AppRoutes.splash);

      expect(routes.single.settings.name, AppRoutes.splash);
    });

    test('starts at the splash screen for an unknown deep link', () {
      final routes = AppRouter.onGenerateInitialRoutes('/unknown?x=1');

      expect(routes.single.settings.name, AppRoutes.splash);
    });
  });

  group('AppRouter.onGenerateRoute', () {
    test('matches a deep link on its path, ignoring the query', () {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/recover-phone?token=abc'),
      );

      expect(route.settings.name, AppRoutes.recoverPhone);
    });

    test('rejects the verify step without a request id', () {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: AppRoutes.verifyOldPhone),
      );

      expect(route.settings.name, isNot(AppRoutes.verifyOldPhone));
    });
  });
}
