import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/dio_factory.dart';
import '../../domain/repos/auth_repo.dart';
import '../apis/auth_api_service.dart';
import '../models/login_request_body.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.authApiService});

  final AuthApiService authApiService;

  @override
  Future<ApiResult<UserModel>> login(LoginRequestBody body) async {
    try {
      final user = await authApiService.login(body);
      if (user.token != null && user.token!.isNotEmpty) {
        await DioFactory.saveToken(user.token!);
      }
      return ApiResult.success(user);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> logout() async {
    try {
      await authApiService.logout();
      await DioFactory.clearToken();
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<UserModel>> getProfile() async {
    try {
      final user = await authApiService.getProfile();
      return ApiResult.success(user);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
