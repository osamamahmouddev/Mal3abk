import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../data/models/team_detail_model.dart';
import '../repos/teams_repo.dart';

class JoinTeamByCodeUseCase {
  JoinTeamByCodeUseCase({required this.teamsRepo});

  static final RegExp _codePattern = RegExp(r'^[A-Z0-9]{4,12}$');

  final TeamsRepo teamsRepo;

  Future<ApiResult<TeamDetailModel>> call(String rawCode) {
    final code = rawCode.trim().toUpperCase();
    if (!_codePattern.hasMatch(code)) {
      return Future.value(
        const ApiResult.failure(
          AppApiFailure(message: 'errors.teams.invalid_invite_code'),
        ),
      );
    }
    return teamsRepo.acceptInvitation(code);
  }
}
