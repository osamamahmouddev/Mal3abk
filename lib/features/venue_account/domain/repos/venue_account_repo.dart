import '../../../../core/network/api_result.dart';

/// The signed-in owner's name, email and mobile.
class VenueAccountProfile {
  const VenueAccountProfile({
    required this.fullName,
    required this.phoneNumber,
    this.email,
  });

  final String fullName;
  final String phoneNumber;
  final String? email;
}

abstract class VenueAccountRepo {
  Future<ApiResult<VenueAccountProfile>> getProfile();

  Future<ApiResult<void>> updateName(String fullName);

  Future<ApiResult<void>> changePassword(String current, String next);

  /// The authenticator secret and its `otpauth://` link.
  Future<ApiResult<(String, String)>> enrollTotp();

  Future<ApiResult<void>> confirmTotp(String code);

  /// Password check, then a code to [newEmail].
  Future<ApiResult<void>> startEmailChange(String newEmail, String password);

  Future<ApiResult<void>> confirmEmailChange(String code);

  /// Password check, then codes to the current and the new number; returns
  /// the change request id.
  Future<ApiResult<String>> startPhoneChange(String newPhone, String password);

  Future<ApiResult<void>> verifyOldPhone(String requestId, String code);

  Future<ApiResult<void>> verifyNewPhone(String requestId, String code);
}
