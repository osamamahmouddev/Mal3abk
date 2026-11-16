import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../features/notifications/data/apis/notifications_api_service.dart';
import '../local_storage/auth_token_storage.dart';
import '../routes/app_navigator.dart';
import '../routes/deep_link_resolver.dart';
import '../utils/app_logger.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Already initialized or platform default
  }
}

class PushNotificationService {
  PushNotificationService({
    required this.notificationsApiService,
    required this.tokenStorage,
  });

  final NotificationsApiService notificationsApiService;
  final AuthTokenStorage tokenStorage;

  bool _initialized = false;
  String? _lastRegisteredToken;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    try {
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      AppLogger.d('FCM permission: ${settings.authorizationStatus.name}');

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        AppLogger.d('Foreground push received');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        AppLogger.d('App opened from a push');
        openFromPush(message.data);
      });

      final initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();
      if (initialMessage != null) {
        AppLogger.d('App launched from a push');
        openFromPush(initialMessage.data);
      }

      FirebaseMessaging.instance.onRegistered.listen((newToken) {
        _lastRegisteredToken = null;
        syncPushToken(forcedToken: newToken);
      });

      await syncPushToken();
    } catch (e) {
      AppLogger.w('Push setup failed: ${e.runtimeType}');
    }
  }

  /// Opens the screen a tapped push points to. The link is checked by
  /// [DeepLinkResolver]: unknown or foreign links open nothing.
  static void openFromPush(Map<String, dynamic> data) {
    final link = data['deepLink'] ?? data['deep_link'] ?? data['link'];
    final target = DeepLinkResolver.resolve(link is String ? link : null);
    if (target != null) AppNavigator.openDeepLink(target);
  }

  Future<void> syncPushToken({String? forcedToken}) async {
    try {
      final hasSession = await tokenStorage.hasSession();
      if (!hasSession) return;

      var token = forcedToken;
      if (token == null || token.isEmpty) {
        // ignore: deprecated_member_use
        token = await FirebaseMessaging.instance.getToken();
      }
      if (token == null || token.isEmpty || token == _lastRegisteredToken) {
        return;
      }

      final platform = Platform.isAndroid
          ? 'Android'
          : (Platform.isIOS ? 'Ios' : 'Web');
      await notificationsApiService.registerPushToken({
        'token': token,
        'platform': platform,
      });
      _lastRegisteredToken = token;
      AppLogger.d('Push token registered');
    } catch (e) {
      AppLogger.w('Push token registration failed: ${e.runtimeType}');
    }
  }

  Future<void> unregisterPushToken() async {
    try {
      final token =
          _lastRegisteredToken ??
          // ignore: deprecated_member_use
          await FirebaseMessaging.instance.getToken();
      if (token != null && token.isNotEmpty) {
        await notificationsApiService.unregisterPushToken({'token': token});
        // ignore: deprecated_member_use
        await FirebaseMessaging.instance.deleteToken();
      }
      _lastRegisteredToken = null;
      AppLogger.d('Push token unregistered');
    } catch (e) {
      AppLogger.w('Push token unregistration failed: ${e.runtimeType}');
    }
  }
}
