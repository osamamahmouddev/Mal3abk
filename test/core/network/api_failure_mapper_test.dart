import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_failure_mapper.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';

import '../../helpers/dio_errors.dart';

void main() {
  group('ApiFailureMapper', () {
    test('maps an identity ProblemDetails title to its localization key', () {
      final failure = ApiFailureMapper.map(
        badResponse(400, {
          'title': 'Identity.InvalidOtpCode',
          'detail': 'Invalid code',
          'status': 400,
          'traceId': 'trace-1',
        }),
      );

      expect(failure.message, 'errors.identity.invalid_otp');
      expect(failure.code, 'Identity.InvalidOtpCode');
      expect(failure.statusCode, 400);
      expect(failure.extraData['traceId'], 'trace-1');
    });

    test('maps a validation problem with its field errors', () {
      final failure = ApiFailureMapper.map(
        badResponse(400, {
          'title': 'خطأ في التحقق',
          'code': 'validation_failed',
          'errors': {
            'PhoneNumber': ['رقم غير صالح'],
          },
        }),
      );

      expect(failure.message, 'errors.validation_failed');
      expect(failure.fieldMessage('PhoneNumber'), 'رقم غير صالح');
    });

    test('prefers errorCode over title', () {
      final failure = ApiFailureMapper.map(
        badResponse(401, {
          'title': 'Unauthorized',
          'errorCode': 'AUTH_REFRESH_TOKEN_REUSE',
        }),
      );

      expect(failure.code, 'AUTH_REFRESH_TOKEN_REUSE');
      expect(failure.message, 'errors.identity.session_expired');
    });

    test('falls back to a status key for an unknown code', () {
      final failure = ApiFailureMapper.map(
        badResponse(409, {'title': 'Booking.Unknown'}),
      );

      expect(failure.message, 'errors.conflict');
    });

    test('maps a 401 without a body to the unauthorized key', () {
      final failure = ApiFailureMapper.map(badResponse(401));

      expect(failure.message, 'errors.unauthorized');
      expect(failure.statusCode, 401);
    });

    test('maps 5xx to the server key', () {
      final failure = ApiFailureMapper.map(badResponse(503, ''));

      expect(failure.message, 'errors.server');
    });

    test('maps a timeout to the timeout key', () {
      final failure = ApiFailureMapper.map(
        DioException.connectionTimeout(
          timeout: const Duration(seconds: 30),
          requestOptions: RequestOptions(path: '/test'),
        ),
      );

      expect(failure.message, 'errors.timeout');
    });

    test('maps a connection error to the network key', () {
      final failure = ApiFailureMapper.map(
        DioException.connectionError(
          requestOptions: RequestOptions(path: '/test'),
          reason: 'offline',
        ),
      );

      expect(failure.message, 'errors.network');
    });

    test('passes an AppApiFailure through unchanged', () {
      const original = AppApiFailure(message: 'errors.identity.otp_format');

      expect(ApiFailureMapper.map(original), same(original));
    });

    test('maps any other error to the unexpected key', () {
      final failure = ApiFailureMapper.map(StateError('boom'));

      expect(failure.message, ApiFailureMapper.unexpectedErrorKey);
    });
    group('Firebase phone sign-in errors', () {
      for (final entry in {
        'invalid-verification-code': 'errors.identity.invalid_otp',
        'session-expired': 'errors.identity.otp_expired',
        'too-many-requests': 'common.too_many_requests',
        'network-request-failed': 'errors.network',
        'internal-error': ApiFailureMapper.unexpectedErrorKey,
      }.entries) {
        test('maps ${entry.key} to ${entry.value}', () {
          final failure = ApiFailureMapper.map(
            FirebaseAuthException(code: entry.key, message: 'raw English text'),
          );

          expect(failure.message, entry.value);
          expect(failure.code, 'firebase.${entry.key}');
        });
      }
    });
  });
}
