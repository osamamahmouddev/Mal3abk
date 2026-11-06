import '../../../../core/network/api_result.dart';
import '../../../auth/domain/repos/auth_repo.dart';
import '../repos/account_repo.dart';

/// Deletes the account, then drops the local session the server just revoked.
class DeleteAccountUseCase {
  DeleteAccountUseCase({required this.accountRepo, required this.authRepo});

  final AccountRepo accountRepo;
  final AuthRepo authRepo;

  Future<ApiResult<void>> call({required String stepUpToken}) async {
    final result = await accountRepo.deleteAccount(stepUpToken: stepUpToken);
    return result.when(
      success: (_) => authRepo.clearSession(),
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
