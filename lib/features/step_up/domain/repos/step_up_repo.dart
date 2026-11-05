import '../../../../core/network/api_result.dart';

abstract class StepUpRepo {
  /// Texts a one-time code to the account's current phone.
  Future<ApiResult<void>> sendCode();

  /// Exchanges the code for a short-lived token for [scope].
  Future<ApiResult<String>> verify({
    required String scope,
    required String code,
  });
}
