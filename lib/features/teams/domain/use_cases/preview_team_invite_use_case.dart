import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/routes/invite_link.dart';
import '../../data/models/team_invite_preview_model.dart';
import '../repos/teams_repo.dart';

/// Looks up the team behind an invite code without joining it. A code of the
/// wrong shape never reaches the server.
class PreviewTeamInviteUseCase {
  PreviewTeamInviteUseCase({required this.teamsRepo});

  final TeamsRepo teamsRepo;

  Future<ApiResult<TeamInvitePreviewModel>> call(String rawCode) {
    final code = InviteLink.normalize(rawCode);
    if (code == null) {
      return Future.value(
        const ApiResult.failure(
          AppApiFailure(message: 'errors.teams.invalid_invite_code'),
        ),
      );
    }
    return teamsRepo.previewInvitation(code);
  }
}
