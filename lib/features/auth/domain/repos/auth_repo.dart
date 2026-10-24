import '../../../../core/network/api_result.dart';
import '../../data/models/login_request_body.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepo {
  Future<ApiResult<UserModel>> login(LoginRequestBody body);
  Future<ApiResult<void>> logout();
  Future<ApiResult<UserModel>> getProfile();
}
