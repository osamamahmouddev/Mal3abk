import 'dart:convert';

import 'package:dio/dio.dart';

import 'app_api_failure.dart';

/// Maps every error to an [AppApiFailure] whose `message` is a localization
/// key. The API answers with RFC 9457 ProblemDetails; the machine code is in
/// `errorCode`, `code` (validation) or `title` (identity errors).
class ApiFailureMapper {
  const ApiFailureMapper._();

  static const String unexpectedErrorKey = 'common.unexpected_error';

  static final RegExp _codePattern = RegExp(r'^[A-Za-z]+(\.[A-Za-z]+)+$');

  static const Map<String, String> _codeKeys = {
    'validation_failed': 'errors.validation_failed',
    'VALIDATION_FAILED': 'errors.validation_failed',
    'RATE_LIMIT_EXCEEDED': 'common.too_many_requests',
    'Identity.RateLimitExceeded': 'common.too_many_requests',
    'Identity.InvalidEgyptianPhoneNumber': 'errors.identity.invalid_phone',
    'Identity.InvalidPhoneNumber': 'errors.identity.invalid_phone',
    'Identity.NotMobileNumber': 'errors.identity.invalid_phone',
    'Identity.PhoneNumberParseException': 'errors.identity.invalid_phone',
    'PhoneNumber.InvalidEgyptianNumber': 'errors.identity.invalid_phone',
    'Identity.InvalidOtpCode': 'errors.identity.invalid_otp',
    'Identity.OtpExpiredOrNotFound': 'errors.identity.otp_expired',
    'AUTH_OTP_EXPIRED': 'errors.identity.otp_expired',
    'Identity.OtpMaxAttemptsExceeded': 'errors.identity.otp_max_attempts',
    'AUTH_OTP_MAX_ATTEMPTS': 'errors.identity.otp_max_attempts',
    'Identity.InvalidTurnstileToken': 'errors.identity.turnstile_failed',
    'Identity.OtpDeliveryFailed': 'errors.identity.otp_delivery_failed',
    'Identity.InvalidRefreshToken': 'errors.identity.session_expired',
    'Identity.RefreshTokenExpired': 'errors.identity.session_expired',
    'Identity.RefreshTokenReused': 'errors.identity.session_expired',
    'AUTH_TOKEN_REVOKED': 'errors.identity.session_expired',
    'AUTH_REFRESH_TOKEN_REUSE': 'errors.identity.session_expired',
    'Identity.InvalidStepUpToken': 'errors.identity.step_up_expired',
    'Identity.PhoneChangeCooldownActive':
        'errors.identity.phone_change_cooldown',
    'Identity.PhoneNumberAlreadyInUse': 'errors.identity.phone_in_use',
    'Identity.SamePhoneNumber': 'errors.identity.same_phone',
    'Identity.PhoneChangeRequestExpired':
        'errors.identity.phone_change_expired',
    'Identity.PhoneChangeRequestNotFound':
        'errors.identity.phone_change_expired',
    'Identity.InvalidPhoneChangeState': 'errors.identity.phone_change_expired',
    'Identity.MissingVerificationHash': 'errors.identity.phone_change_expired',
    'Identity.InvalidRecoveryToken': 'errors.identity.recovery_link_invalid',
    'Identity.RecoveryTokenExpired': 'errors.identity.recovery_link_invalid',
    'Identity.InvalidRecoveryState': 'errors.identity.recovery_link_invalid',
    'Identity.UserNotFound': 'errors.identity.user_not_found',
  };

  static AppApiFailure map(Object error, [StackTrace? stackTrace]) {
    if (error is DioException) {
      return fromDioException(error);
    }
    if (error is AppApiFailure) {
      return error;
    }
    return const AppApiFailure(
      message: unexpectedErrorKey,
      code: 'unexpected.error',
    );
  }

  static AppApiFailure fromDioException(DioException exception) {
    if (exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.sendTimeout ||
        exception.type == DioExceptionType.receiveTimeout) {
      return const AppApiFailure(
        message: 'errors.timeout',
        code: 'network.timeout',
      );
    }

    if (exception.type == DioExceptionType.connectionError) {
      return const AppApiFailure(
        message: 'errors.network',
        code: 'network.connection',
      );
    }

    final response = exception.response;
    final statusCode = response?.statusCode;
    final retryAfter = int.tryParse(
      response?.headers.value('retry-after') ?? '',
    );
    final extraData = <String, dynamic>{'retryAfterSeconds': ?retryAfter};

    final problem = _decodeProblem(response?.data);
    if (problem == null) {
      return AppApiFailure(
        message: _statusKey(statusCode),
        code: 'network.error',
        statusCode: statusCode,
        extraData: extraData,
      );
    }

    final code = _resolveCode(problem);
    final traceId = _stringValue(problem['traceId']);
    if (traceId != null) extraData['traceId'] = traceId;

    return AppApiFailure(
      message: _codeKeys[code] ?? _statusKey(statusCode),
      code: code,
      statusCode: statusCode,
      fieldErrors: _fieldErrors(problem['errors']),
      extraData: extraData,
    );
  }

  static Map<String, dynamic>? _decodeProblem(Object? data) {
    if (data is Map<String, dynamic>) return data;
    if (data is String && data.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) return decoded;
      } on FormatException {
        return null;
      }
    }
    return null;
  }

  static String? _resolveCode(Map<String, dynamic> problem) {
    final explicitCode =
        _stringValue(problem['errorCode']) ?? _stringValue(problem['code']);
    if (explicitCode != null) return explicitCode;

    final title = _stringValue(problem['title']);
    if (title != null && _codePattern.hasMatch(title)) return title;
    return null;
  }

  static Map<String, List<String>> _fieldErrors(Object? rawErrors) {
    final fieldErrors = <String, List<String>>{};
    if (rawErrors is! Map<String, dynamic>) return fieldErrors;

    for (final entry in rawErrors.entries) {
      final messages = entry.value;
      if (messages is! List) continue;
      final values = messages.whereType<String>().toList();
      if (values.isNotEmpty) fieldErrors[entry.key] = values;
    }
    return fieldErrors;
  }

  static String _statusKey(int? statusCode) {
    return switch (statusCode) {
      401 => 'errors.unauthorized',
      403 => 'errors.forbidden',
      404 => 'errors.not_found',
      409 => 'errors.conflict',
      429 => 'common.too_many_requests',
      final int code when code >= 500 => 'errors.server',
      _ => unexpectedErrorKey,
    };
  }

  static String? _stringValue(Object? value) {
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
    return null;
  }
}
