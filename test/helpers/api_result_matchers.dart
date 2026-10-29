import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';

/// Matches an `ApiResult.failure` whose message is [messageKey].
Matcher isFailureWith(String messageKey) => isA<ApiFailure<dynamic>>().having(
  (result) => result.failure.message,
  'failure.message',
  messageKey,
);

/// Matches an `ApiResult.success` whose data equals [data].
Matcher isSuccessWith(Object? data) =>
    isA<Success<dynamic>>().having((result) => result.data, 'data', data);
