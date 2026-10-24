import '../../../../core/network/api_result.dart';
import '../../data/models/login_request_body.dart';
import '../../data/models/user_model.dart';
import '../repos/auth_repo.dart';

class LoginUseCase {
  LoginUseCase({required this.authRepo});

  final AuthRepo authRepo;

  Future<ApiResult<UserModel>> call(LoginRequestBody body) async {
    return authRepo.login(body);
  }
}
