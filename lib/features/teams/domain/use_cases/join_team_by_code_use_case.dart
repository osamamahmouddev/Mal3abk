import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/routes/invite_link.dart';
import '../../data/models/team_detail_model.dart';
import '../repos/teams_repo.dart';

class JoinTeamByCodeUseCase {
  JoinTeamByCodeUseCase({required this.teamsRepo});

  /// Team invite codes are exactly this long on the server.
  static const int codeLength = InviteLink.codeLength;

  final TeamsRepo teamsRepo;

  Future<ApiResult<TeamDetailModel>> call(String rawCode) {
    final code = InviteLink.normalize(rawCode);
    if (code == null) {
      return Future.value(
        const ApiResult.failure(
          AppApiFailure(message: 'errors.teams.invalid_invite_code'),
        ),
      );
    }
    return teamsRepo.acceptInvitation(code);
  }
}
