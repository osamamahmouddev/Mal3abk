import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app_api_failure.dart';

class ApiFailureMapper {
  const ApiFailureMapper._();

  static AppApiFailure map(Object error, [StackTrace? stackTrace]) {
    if (error is DioException) {
      return fromDioException(error);
    }
    if (error is AppApiFailure) {
      return error;
    }
    return AppApiFailure(
      message: 'common.unexpected_error'.tr(),
      code: 'unexpected.error',
    );
  }

  static AppApiFailure fromDioException(DioException exception) {
    if (exception.response?.statusCode == 429) {
      return AppApiFailure(
        message: 'common.too_many_requests'.tr(),
        code: 'too_many_requests',
      );
    }

    if (exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.sendTimeout ||
        exception.type == DioExceptionType.receiveTimeout) {
      return AppApiFailure(
        message: 'errors.timeout'.tr(),
        code: 'network.timeout',
      );
    }

    if (exception.type == DioExceptionType.connectionError) {
      return AppApiFailure(
        message: 'errors.network'.tr(),
        code: 'network.connection',
      );
    }

    final data = exception.response?.data;
    if (data is Map<String, dynamic>) {
      return _fromJson(data, fallbackMessage: exception.message);
    }
    if (data is String && data.trim().isNotEmpty) {
      return _fromString(data.trim(), fallbackMessage: exception.message);
    }
    if (data is List && data.isNotEmpty) {
      final firstItem = data.first;
      if (firstItem is String && firstItem.trim().isNotEmpty) {
        return AppApiFailure(message: firstItem.trim(), code: 'network.error');
      }
      if (firstItem is Map<String, dynamic>) {
        return _fromJson(firstItem, fallbackMessage: exception.message);
      }
    }

    return AppApiFailure(
      message: exception.message ?? 'common.unexpected_error'.tr(),
      code: 'network.error',
    );
  }

  static AppApiFailure _fromString(String value, {String? fallbackMessage}) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) {
        return _fromJson(decoded, fallbackMessage: fallbackMessage);
      }
      if (decoded is List && decoded.isNotEmpty) {
        final firstItem = decoded.first;
        if (firstItem is Map<String, dynamic>) {
          return _fromJson(firstItem, fallbackMessage: fallbackMessage);
        }
      }
    } catch (_) {
      // Keep original text
    }

    return AppApiFailure(message: value, code: 'network.error');
  }

  static AppApiFailure _fromJson(
    Map<String, dynamic> json, {
    String? fallbackMessage,
  }) {
    final code = json['code']?.toString();
    final message = _resolvePrimaryMessage(json);

    final fieldErrors = <String, List<String>>{};
    final rawFieldErrors = json['field_errors'];
    if (rawFieldErrors is List) {
      for (final item in rawFieldErrors) {
        if (item is! Map<String, dynamic>) continue;
        final field = item['field']?.toString();
        final itemMessage = item['message']?.toString();
        if (field == null || field.isEmpty || itemMessage == null) continue;
        fieldErrors.putIfAbsent(field, () => <String>[]).add(itemMessage);
      }
    }

    final detail = json['detail'];
    if (detail is List) {
      for (final item in detail) {
        if (item is! Map<String, dynamic>) continue;
        final itemMessage = item['msg']?.toString();
        final loc = item['loc'];
        final field = loc is List && loc.isNotEmpty ? loc.last.toString() : '';
        if (field.isEmpty || itemMessage == null || itemMessage.isEmpty) {
          continue;
        }
        fieldErrors.putIfAbsent(field, () => <String>[]).add(itemMessage);
      }
    }

    final nonFieldErrors = <String>[];
    final rawNonFieldErrors = json['non_field_errors'];
    if (rawNonFieldErrors is List) {
      for (final item in rawNonFieldErrors) {
        if (item is String) {
          nonFieldErrors.add(item);
        } else if (item is Map<String, dynamic>) {
          final itemMessage = item['message']?.toString();
          if (itemMessage != null && itemMessage.isNotEmpty) {
            nonFieldErrors.add(itemMessage);
          }
        }
      }
    }

    var resolvedMessage =
        message ??
        _firstFieldMessage(fieldErrors) ??
        (nonFieldErrors.isNotEmpty ? nonFieldErrors.first : null) ??
        fallbackMessage ??
        'common.unexpected_error'.tr();

    if (resolvedMessage.trim().replaceAll('.', '').toLowerCase() ==
        'too many requests please try again later') {
      resolvedMessage = 'common.too_many_requests'.tr();
    }

    return AppApiFailure(
      code: code,
      message: resolvedMessage,
      fieldErrors: fieldErrors,
      nonFieldErrors: nonFieldErrors,
    );
  }

  static String? _firstFieldMessage(Map<String, List<String>> fieldErrors) {
    for (final value in fieldErrors.values) {
      if (value.isNotEmpty) return value.first;
    }
    return null;
  }

  static String? _resolvePrimaryMessage(Map<String, dynamic> json) {
    return _stringValue(json['message']) ??
        _stringValue(json['detail']) ??
        _stringValue(json['error']) ??
        _nestedMessage(json['error']) ??
        _nestedMessage(json['detail']);
  }

  static String? _nestedMessage(Object? value) {
    if (value is! Map<String, dynamic>) {
      return null;
    }
    return _stringValue(value['message']) ?? _stringValue(value['detail']);
  }

  static String? _stringValue(Object? value) {
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
    return null;
  }
}
