import '../../../../core/network/api_result.dart';
import '../../data/models/register_owner_request_body.dart';

abstract class VenueAuthRepo {
  /// Signs in and saves the session as a venue session.
  Future<ApiResult<void>> login({
    required String email,
    required String password,
    String? totpCode,
  });

  Future<ApiResult<void>> registerOwner(RegisterOwnerRequestBody body);

  Future<ApiResult<void>> resendVerification(String email);

  Future<ApiResult<void>> forgotPassword(String email);
}
