import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/routes/app_navigator.dart';
import 'package:mal3abk/core/routes/deep_link_resolver.dart';
import 'package:mal3abk/core/routes/routes.dart';
import 'package:mal3abk/core/services/push_notification_service.dart';

class RecordingObserver extends NavigatorObserver {
  final List<String?> pushed = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed.add(route.settings.name);
  }
}

void main() {
  tearDown(AppNavigator.reset);

  group('AppNavigator deep links', () {
    test('a link tapped before the shell is shown waits for it', () {
      const target = DeepLinkTarget(
        route: AppRoutes.bookingDetails,
        arguments: 'b-1',
      );

      AppNavigator.openDeepLink(target);

      expect(AppNavigator.pendingLink, same(target));
    });

    testWidgets('the waiting link opens once the shell is ready', (
      tester,
    ) async {
      final observer = RecordingObserver();
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          navigatorObservers: [observer],
          onGenerateRoute: (settings) => MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => const Placeholder(),
          ),
        ),
      );
      observer.pushed.clear();

      AppNavigator.openDeepLink(
        const DeepLinkTarget(route: AppRoutes.venueProfile, arguments: 'v-1'),
      );
      expect(observer.pushed, isEmpty);

      AppNavigator.onShellReady();
      await tester.pumpAndSettle();

      expect(observer.pushed, [AppRoutes.venueProfile]);
      expect(AppNavigator.pendingLink, isNull);
    });
  });

  group('PushNotificationService.openFromPush', () {
    test('queues a valid malabak:// link', () {
      PushNotificationService.openFromPush({'deepLink': 'malabak://match/m-7'});

      expect(AppNavigator.pendingLink?.route, AppRoutes.matchDetails);
      expect(AppNavigator.pendingLink?.arguments, 'm-7');
    });

    test('ignores foreign or missing links', () {
      PushNotificationService.openFromPush({
        'deepLink': 'https://evil.example.com',
      });
      PushNotificationService.openFromPush({'title': 'no link'});

      expect(AppNavigator.pendingLink, isNull);
    });
  });
}
