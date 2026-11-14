import '../../../../core/network/api_result.dart';
import '../../data/models/team_invitation_model.dart';
import '../repos/teams_repo.dart';

/// The code players already have keeps working: the team's current code is
/// shown as is, and a new one is made only when there is none or it expired.
/// Making a new code on the server kills the old one.
class GetTeamInviteCodeUseCase {
  GetTeamInviteCodeUseCase({required this.teamsRepo, DateTime Function()? now})
    : now = now ?? _utcNow;

  final TeamsRepo teamsRepo;
  final DateTime Function() now;

  static DateTime _utcNow() => DateTime.now().toUtc();

  Future<ApiResult<TeamInvitationModel>> call(String teamId) async {
    final team = await teamsRepo.getTeam(teamId);
    return team.when(
      success: (team) {
        final code = team.inviteCode;
        final expiresAt = team.inviteCodeExpiresAtUtc;
        final usable =
            code != null &&
            code.isNotEmpty &&
            (expiresAt == null || expiresAt.isAfter(now()));
        if (!usable) return teamsRepo.createInvitation(teamId);
        return ApiResult.success(
          TeamInvitationModel(
            teamId: team.id,
            inviteCode: code,
            expiresAtUtc: expiresAt,
          ),
        );
      },
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
