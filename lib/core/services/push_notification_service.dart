import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../features/notifications/data/apis/notifications_api_service.dart';
import '../local_storage/auth_token_storage.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Already initialized or platform default
  }
  debugPrint('Handling background FCM message: ${message.messageId}');
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
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      debugPrint('FCM AuthorizationStatus: ${settings.authorizationStatus}');

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Received foreground FCM message: ${message.notification?.title}');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('App opened from notification: ${message.data}');
      });

      final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        debugPrint('App launched via initial notification: ${initialMessage.data}');
      }

      FirebaseMessaging.instance.onRegistered.listen((newToken) {
        _lastRegisteredToken = null;
        syncPushToken(forcedToken: newToken);
      });

      await syncPushToken();
    } catch (e) {
      debugPrint('PushNotificationService initialization error: $e');
    }
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
      if (token == null || token.isEmpty || token == _lastRegisteredToken) return;

      final platform = Platform.isAndroid ? 'Android' : (Platform.isIOS ? 'Ios' : 'Web');
      await notificationsApiService.registerPushToken({
        'token': token,
        'platform': platform,
      });
      _lastRegisteredToken = token;
      debugPrint('Registered FCM token with backend successfully.');
    } catch (e) {
      debugPrint('Failed to register FCM token with backend: $e');
    }
  }

  Future<void> unregisterPushToken() async {
    try {
      // ignore: deprecated_member_use
      final token = _lastRegisteredToken ?? await FirebaseMessaging.instance.getToken();
      if (token != null && token.isNotEmpty) {
        await notificationsApiService.unregisterPushToken({'token': token});
        // ignore: deprecated_member_use
        await FirebaseMessaging.instance.deleteToken();
      }
      _lastRegisteredToken = null;
      debugPrint('Unregistered FCM token successfully.');
    } catch (e) {
      debugPrint('Failed to unregister FCM token: $e');
    }
  }
}
