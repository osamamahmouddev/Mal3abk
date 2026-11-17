import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/matches/data/apis/matches_api_service.dart';
import 'package:mal3abk/features/matches/data/repos/matches_repo_impl.dart';
import 'package:mal3abk/features/notifications/data/apis/notifications_api_service.dart';
import 'package:mal3abk/features/notifications/data/models/notification_model.dart';
import 'package:mal3abk/features/notifications/data/repos/notifications_repo_impl.dart';
import 'package:mal3abk/features/teams/data/apis/teams_api_service.dart';
import 'package:mal3abk/features/teams/data/models/create_team_request_body.dart';
import 'package:mal3abk/features/teams/data/models/team_detail_model.dart';
import 'package:mal3abk/features/teams/data/repos/teams_repo_impl.dart';
import 'package:mal3abk/features/teams/domain/use_cases/create_team_use_case.dart';

/// Shared plumbing for the cycle suites that run against the local stack
/// (API on 127.0.0.1:5000, Mailpit on 127.0.0.1:8025; override with
/// MAL3ABK_API / MAL3ABK_MAILPIT). Players go through the app's own API
/// services and repos, so the app's models and error mapping are exercised.
class LocalStack {
  LocalStack._();

  static final String apiUrl =
      Platform.environment['MAL3ABK_API'] ?? 'http://127.0.0.1:5000';
  static final String mailpitUrl =
      Platform.environment['MAL3ABK_MAILPIT'] ?? 'http://127.0.0.1:8025';

  static final Random _random = Random();
  static final String runId = DateTime.now().millisecondsSinceEpoch
      .toRadixString(36);
  static int _counter = 0;

  static final Dio plain = paced(Dio());

  /// Turns off the test binding's fake HTTP and checks the stack answers.
  static Future<bool> start() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = null;
    try {
      await plain.get<dynamic>('$apiUrl/api/v1/ping');
      await plain.get<dynamic>('$mailpitUrl/api/v1/info');
      return true;
    } on DioException {
      return false;
    }
  }

  /// A phone number no earlier run has used.
  static String newPhone() => '+2010${10000000 + _random.nextInt(89999999)}';

  /// A brand-new player, signed in through `POST /auth/firebase` with the
  /// Development token (`dev:<phone>`), so suites do not wait on the OTP
  /// rate limit. The OTP and real Firebase paths have suites of their own.
  static Future<LocalPlayer> newPlayer(String name, {String? phone}) async {
    final number = phone ?? newPhone();
    final response = await plain.post<Map<String, dynamic>>(
      '$apiUrl/api/v1/auth/firebase',
      data: {'idToken': 'dev:$number', 'fullName': name},
    );
    return LocalPlayer.fromSession(name, number, response.data!);
  }

  /// The newest 6-digit code Mailpit holds for [phone] (E.164).
  static Future<String> otpFor(String phone, {String? notCode}) async {
    final digits = phone.replaceAll('+', '');
    for (var i = 0; i < 60; i++) {
      final list = await plain.get<Map<String, dynamic>>(
        '$mailpitUrl/api/v1/search',
        queryParameters: {'query': 'to:sms+$digits@malabak.local'},
      );
      final messages = (list.data!['messages'] as List)
          .cast<Map<String, dynamic>>();
      if (messages.isNotEmpty) {
        final detail = await plain.get<Map<String, dynamic>>(
          '$mailpitUrl/api/v1/message/${messages.first['ID']}',
        );
        final code = RegExp(
          r'\b[0-9]{6}\b',
        ).firstMatch(detail.data!['Text'] as String)?.group(0);
        if (code != null && code != notCode) return code;
      }
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
    throw TestFailure('no OTP reached Mailpit for $phone');
  }

  /// Sends an OTP, retrying while the API asks to wait (429 + Retry-After).
  static Future<void> sendOtp(String phone) async {
    for (var attempt = 1; ; attempt++) {
      try {
        await plain.post<dynamic>(
          '$apiUrl/api/v1/auth/otp/send',
          data: {'phoneNumber': phone, 'turnstileToken': 'dev'},
        );
        return;
      } on DioException catch (e) {
        final wait = int.tryParse(
          e.response?.headers.value('retry-after') ?? '',
        );
        if (e.response?.statusCode != 429 || wait == null || attempt > 5) {
          rethrow;
        }
        await Future<void>.delayed(Duration(seconds: wait + 1));
      }
    }
  }

  static Future<TeamDetailModel> createTeam(
    LocalPlayer captain, {
    bool isPublic = true,
  }) async {
    _counter++;
    final created = ok(
      await CreateTeamUseCase(teamsRepo: captain.teams)(
        CreateTeamRequestBody(
          name: 'Cycle $runId $_counter',
          city: 'Nasr City',
          governorate: 'Cairo',
        ),
        isPublic: isPublic,
      ),
      '${captain.name} creates a team',
    );
    return created.team;
  }

  /// Waits for the notification the outbox dispatcher delivers within a few
  /// seconds; fails with what the player did get instead.
  static Future<NotificationModel> notificationFor(
    LocalPlayer player,
    String type, {
    bool Function(NotificationModel n)? where,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final deadline = DateTime.now().add(timeout);
    var seen = <String>[];
    while (DateTime.now().isBefore(deadline)) {
      final page = ok(
        await player.notifications.getNotifications(),
        '${player.name} reads notifications',
      );
      seen = page.items.map((n) => n.type).toList();
      for (final n in page.items) {
        if (n.type == type && (where == null || where(n))) return n;
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    throw TestFailure(
      '${player.name} never got "$type" (got: ${seen.join(', ')})',
    );
  }

  /// Notifications of [type] the player holds right now.
  static Future<int> countOf(LocalPlayer player, String type) async {
    final page = ok(
      await player.notifications.getNotifications(),
      '${player.name} reads notifications',
    );
    return page.items.where((n) => n.type == type).length;
  }

  /// Skips the calling test when the stack is down.
  static bool ready(bool stackUp) {
    if (!stackUp) markTestSkipped('local API or Mailpit is not running');
    return stackUp;
  }
}

T ok<T>(ApiResult<T> result, String step) => result.when(
  success: (data) => data,
  failure: (f) => throw TestFailure('$step failed: ${f.code} ${f.message}'),
);

/// The API error code of a call expected to fail.
String failureCode<T>(ApiResult<T> result) => result.when(
  success: (_) => throw TestFailure('expected a failure, got success'),
  failure: (f) => f.code ?? f.message,
);

/// A signed-in player with the app's repos bound to their own session.
class LocalPlayer {
  LocalPlayer._({
    required this.name,
    required this.phone,
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.dio,
  }) : teams = TeamsRepoImpl(teamsApiService: TeamsApiService(dio)),
       matches = MatchesRepoImpl(matchesApiService: MatchesApiService(dio)),
       notifications = NotificationsRepoImpl(
         notificationsApiService: NotificationsApiService(dio),
       );

  factory LocalPlayer.fromSession(
    String name,
    String phone,
    Map<String, dynamic> session,
  ) {
    final access = session['accessToken'] as String;
    return LocalPlayer._(
      name: name,
      phone: phone,
      id: session['userId'] as String,
      accessToken: access,
      refreshToken: session['refreshToken'] as String,
      dio: paced(
        Dio(
          BaseOptions(
            baseUrl: LocalStack.apiUrl,
            headers: {'Authorization': 'Bearer $access'},
          ),
        ),
      ),
    );
  }

  final String name;
  final String phone;
  final String id;
  final String accessToken;
  final String refreshToken;
  final Dio dio;
  final TeamsRepoImpl teams;
  final MatchesRepoImpl matches;
  final NotificationsRepoImpl notifications;
}

/// The API allows 100 requests a minute per caller and queues 10 more; the
/// suites can go past that. A request refused with 429 is retried once the
/// window has turned.
Dio paced(Dio dio) {
  dio.options
    ..connectTimeout = const Duration(seconds: 5)
    ..receiveTimeout = const Duration(seconds: 75);
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) async {
        final options = error.requestOptions;
        final retries = (options.extra['rateLimitRetries'] as int?) ?? 0;
        if (error.response?.statusCode != 429 || retries >= 3) {
          return handler.next(error);
        }
        final wait =
            int.tryParse(error.response?.headers.value('retry-after') ?? '') ??
            61;
        await Future<void>.delayed(Duration(seconds: wait + 1));
        options.extra['rateLimitRetries'] = retries + 1;
        try {
          handler.resolve(await dio.fetch<dynamic>(options));
        } on DioException catch (e) {
          handler.next(e);
        }
      },
    ),
  );
  return dio;
}
