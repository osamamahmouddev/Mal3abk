import '../../../../core/network/api_result.dart';
import '../../data/models/create_team_request_body.dart';
import '../../data/models/team_detail_model.dart';
import '../../data/models/team_discovery_page_model.dart';
import '../../data/models/team_invitation_model.dart';
import '../../data/models/team_join_request_model.dart';
import '../../data/models/team_leaderboard_page_model.dart';
import '../../data/models/team_profile_model.dart';
import '../../data/models/team_summary_model.dart';
import '../../data/models/update_team_settings_request_body.dart';

abstract class TeamsRepo {
  Future<ApiResult<List<TeamSummaryModel>>> getMyTeams();
  Future<ApiResult<TeamDiscoveryPageModel>> discoverTeams({
    String? search,
    String? governorate,
    bool? isRecruiting,
    bool? isOpenForChallenges,
    int page = 1,
  });
  Future<ApiResult<TeamProfileModel>> getTeamProfile(String teamId);
  Future<ApiResult<TeamDetailModel>> createTeam(CreateTeamRequestBody body);
  Future<ApiResult<TeamDetailModel>> acceptInvitation(String inviteCode);
  Future<ApiResult<TeamInvitationModel>> createInvitation(String teamId);
  Future<ApiResult<TeamJoinRequestModel>> requestToJoin(
    String teamId, {
    String? message,
  });
  Future<ApiResult<List<TeamJoinRequestModel>>> getPendingJoinRequests(
    String teamId,
  );
  Future<ApiResult<void>> approveJoinRequest(String teamId, String requestId);
  Future<ApiResult<void>> declineJoinRequest(String teamId, String requestId);
  Future<ApiResult<void>> leaveTeam(String teamId);
  Future<ApiResult<void>> removeMember(String teamId, String playerId);
  Future<ApiResult<void>> updateSettings(
    String teamId,
    UpdateTeamSettingsRequestBody body,
  );
  Future<ApiResult<void>> transferCaptaincy(
    String teamId,
    String newCaptainPlayerId,
  );
  Future<ApiResult<TeamLeaderboardPageModel>> getLeaderboard({
    String? governorate,
    int page = 1,
  });
}
