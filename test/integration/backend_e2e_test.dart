@Tags(['integration'])
library;

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/auth/data/apis/auth_api_service.dart';
import 'package:mal3abk/features/auth/data/models/send_otp_request_body.dart';
import 'package:mal3abk/features/auth/data/models/verify_otp_request_body.dart';
import 'package:mal3abk/features/booking/data/apis/booking_api_service.dart';
import 'package:mal3abk/features/explore/data/apis/explore_api_service.dart';
import 'package:mal3abk/features/home/data/apis/home_api_service.dart';
import 'package:mal3abk/features/profile/data/apis/profile_api_service.dart';

/// Read-only smoke tests of the public endpoints, plus a short sign-in, against
/// the local API (the `dev` flavor). The whole file skips when it is down.
/// Point it elsewhere with `--dart-define=BASE_URL=...`.
void main() {
  const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://127.0.0.1:5000',
  );
  const mailpitUrl = 'http://127.0.0.1:8025';

  var apiIsUp = true;
  late Dio dio;
  late HomeApiService homeApi;
  late ExploreApiService exploreApi;
  late AuthApiService authApi;

  setUpAll(() async {
    // The test binding is not initialised here, so real HTTP works; this
    // only guards against an inherited override.
    HttpOverrides.global = null;
    try {
      await Dio().get<dynamic>(
        '$baseUrl/api/v1/ping',
        options: Options(receiveTimeout: const Duration(seconds: 3)),
      );
    } on DioException {
      apiIsUp = false;
    }
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    homeApi = HomeApiService(dio);
    exploreApi = ExploreApiService(dio);
    authApi = AuthApiService(dio);
  });

  setUp(() {
    if (!apiIsUp) markTestSkipped('local API is not running at $baseUrl');
  });

  group('End-to-End Real Backend Integration Tests', () {
    test(
      '1. GET /api/v1/home returns feed model with valid sections',
      () async {
        if (!apiIsUp) return;
        final feed = await homeApi.getHomeFeed();
        expect(feed, isNotNull);
        expect(feed.generatedAtUtc, isNotEmpty);
        expect(feed.nearby, isNotNull);
        expect(feed.popularNearYou, isNotNull);
      },
    );

    test('2. GET /api/v1/venues/explore returns seeded venue list', () async {
      if (!apiIsUp) return;
      final result = await exploreApi.exploreVenues();
      expect(result, isNotNull);
      expect(result.items, isNotEmpty);

      final firstVenue = result.items.first;
      expect(firstVenue.venueId, isNotEmpty);
      expect(firstVenue.name, isNotEmpty);
      expect(firstVenue.city, isNotEmpty);
    });

    test(
      '3. GET /api/v1/venues/{id} & pitches returns venue details and pitch list',
      () async {
        if (!apiIsUp) return;
        final result = await exploreApi.exploreVenues();
        final venueId = result.items.first.venueId;

        final details = await exploreApi.getVenueDetails(venueId);
        expect(details.venueId, venueId);
        expect(details.name, isNotEmpty);
        expect(details.depositPolicy, isNotNull);

        final pitches = await exploreApi.getVenuePitches(venueId);
        expect(pitches, isNotEmpty);
        expect(pitches.first.name, isNotEmpty);
      },
    );

    test('4. Full Auth flow -> Profile -> Bookings end-to-end', () async {
      if (!apiIsUp) return;
      // Check if local mailpit is available before running flow
      final mailpitDio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 1),
          receiveTimeout: const Duration(seconds: 1),
        ),
      );
      try {
        await mailpitDio.get('$mailpitUrl/api/v1/messages');
      } catch (_) {
        // Mailpit not available (e.g. running against remote server or in CI)
        return;
      }

      final randomSuffix = (10000000 + Random().nextInt(89999999)).toString();
      final phone = '+2010$randomSuffix';

      // 4.1 Send OTP
      final sendResponse = await authApi.sendOtp(
        SendOtpRequestBody(
          phoneNumber: phone,
          turnstileToken: 'dev-mobile-turnstile',
        ),
      );
      expect(sendResponse.normalizedPhoneNumber, phone);

      // 4.2 Fetch the generated code from Mailpit
      final messagesRes = await mailpitDio.get<Map<String, dynamic>>(
        '$mailpitUrl/api/v1/messages',
      );
      final messages = (messagesRes.data!['messages'] as List)
          .cast<Map<String, dynamic>>();
      expect(messages, isNotEmpty);

      final latestMessageId = messages.first['ID'] as String;
      final messageDetail = await mailpitDio.get<Map<String, dynamic>>(
        '$mailpitUrl/api/v1/message/$latestMessageId',
      );
      final textBody = messageDetail.data!['Text'] as String;
      final otpMatch = RegExp(r'\b[0-9]{6}\b').firstMatch(textBody);
      expect(otpMatch, isNotNull);
      final otpCode = otpMatch!.group(0)!;

      // 4.3 Verify OTP
      final verifyResponse = await authApi.verifyOtp(
        VerifyOtpRequestBody(phoneNumber: phone, code: otpCode),
      );
      expect(verifyResponse.accessToken, isNotEmpty);
      expect(verifyResponse.userId, isNotEmpty);

      // 4.4 Set Authorization header for protected endpoints
      final authDio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {'Authorization': 'Bearer ${verifyResponse.accessToken}'},
        ),
      );

      // 4.5 Fetch authenticated player profile
      final authedProfileApi = ProfileApiService(authDio);
      final profile = await authedProfileApi.getMyProfile();
      expect(profile.userId, verifyResponse.userId);
      expect(profile.phoneNumber, phone);

      // 4.6 Fetch authenticated player bookings
      final authedBookingApi = BookingApiService(authDio);
      final bookings = await authedBookingApi.getMyBookings(
        page: 1,
        pageSize: 20,
      );
      expect(bookings, isNotNull);
      expect(bookings.totalCount, greaterThanOrEqualTo(0));
    });
  });
}
