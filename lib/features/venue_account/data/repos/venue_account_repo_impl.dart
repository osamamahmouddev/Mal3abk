import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/venue_account_repo.dart';
import '../apis/venue_account_api_service.dart';

class VenueAccountRepoImpl implements VenueAccountRepo {
  VenueAccountRepoImpl({required this.apiService});

  final VenueAccountApiService apiService;

  /// `StepUpMethod.Password` on the API.
  static const int _passwordMethod = 0;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  Future<String> _stepUp(String scope, String password) async {
    final json = await apiService.stepUp({
      'scope': scope,
      'method': _passwordMethod,
      'secret': password,
    });
    return (json as Map)['stepUpToken'] as String;
  }

  @override
  Future<ApiResult<VenueAccountProfile>> getProfile() => _guard(() async {
    final json = await apiService.getMe() as Map;
    return VenueAccountProfile(
      fullName: json['fullName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String?,
    );
  });

  @override
  Future<ApiResult<void>> updateName(String fullName) =>
      _guard(() => apiService.updateName({'fullName': fullName.trim()}));

  @override
  Future<ApiResult<void>> changePassword(String current, String next) => _guard(
    () => apiService.changePassword({
      'currentPassword': current,
      'newPassword': next,
    }),
  );

  @override
  Future<ApiResult<(String, String)>> enrollTotp() => _guard(() async {
    final json = await apiService.enrollTotp() as Map;
    return (json['secret'] as String, json['provisioningUri'] as String);
  });

  @override
  Future<ApiResult<void>> confirmTotp(String code) =>
      _guard(() => apiService.confirmTotp({'code': code.trim()}));

  @override
  Future<ApiResult<void>> startEmailChange(String newEmail, String password) =>
      _guard(() async {
        final token = await _stepUp('change_email', password);
        await apiService.startEmailChange({
          'newEmail': newEmail.trim(),
          'stepUpToken': token,
        });
      });

  @override
  Future<ApiResult<void>> confirmEmailChange(String code) =>
      _guard(() => apiService.confirmEmailChange({'code': code.trim()}));

  @override
  Future<ApiResult<String>> startPhoneChange(
    String newPhone,
    String password,
  ) => _guard(() async {
    final token = await _stepUp('change_phone', password);
    final json = await apiService.startPhoneChange({
      'newPhoneNumber': newPhone.trim(),
      'stepUpToken': token,
    });
    return (json as Map)['requestId'] as String;
  });

  @override
  Future<ApiResult<void>> verifyOldPhone(String requestId, String code) =>
      _guard(
        () => apiService.verifyOldPhone({
          'requestId': requestId,
          'code': code.trim(),
        }),
      );

  @override
  Future<ApiResult<void>> verifyNewPhone(String requestId, String code) =>
      _guard(
        () => apiService.verifyNewPhone({
          'requestId': requestId,
          'code': code.trim(),
        }),
      );
}
