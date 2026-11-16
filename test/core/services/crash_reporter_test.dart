import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/services/crash_reporter.dart';

void main() {
  group('CrashReporter', () {
    test('is off until initialized, so tests and debug never report', () {
      expect(CrashReporter.isEnabled, isFalse);
      // Must be a no-op, not a call into an uninitialized Firebase.
      CrashReporter.recordError(StateError('boom'), StackTrace.current);
    });

    test('reduces a network error to type, status, method and path', () {
      final options = RequestOptions(
        baseUrl: 'https://mal3abk.runasp.net',
        path: '/api/v1/auth/otp/verify',
        method: 'POST',
        queryParameters: {'phone': '+201000000000'},
        headers: {'Authorization': 'Bearer secret-token'},
        data: {'code': '123456'},
      );
      final error = DioException(
        requestOptions: options,
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: options,
          statusCode: 400,
          data: {'phoneNumber': '+201000000000'},
        ),
      );

      final redacted = CrashReporter.redact(error).toString();

      expect(
        redacted,
        'DioException(badResponse, 400, POST /api/v1/auth/otp/verify)',
      );
      expect(redacted, isNot(contains('201000000000')));
      expect(redacted, isNot(contains('secret-token')));
      expect(redacted, isNot(contains('123456')));
    });

    test('keeps other errors as they are', () {
      final error = StateError('boom');
      expect(CrashReporter.redact(error), same(error));
    });
  });
}
