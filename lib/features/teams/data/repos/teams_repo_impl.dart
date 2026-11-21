import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/teams_repo.dart';
import '../apis/teams_api_service.dart';
import '../models/accept_team_invitation_request_body.dart';
import '../models/create_team_invitation_request_body.dart';
import '../models/create_team_request_body.dart';
import '../models/join_team_request_body.dart';
import '../models/team_detail_model.dart';
import '../models/team_discovery_page_model.dart';
import '../models/team_invitation_model.dart';
import '../models/team_invite_preview_model.dart';
import '../models/team_join_request_model.dart';
import '../models/team_leaderboard_page_model.dart';
import '../models/team_profile_model.dart';
import '../models/team_summary_model.dart';
import '../models/transfer_captaincy_request_body.dart';
import '../models/update_member_role_request_body.dart';
import '../models/update_team_settings_request_body.dart';

class TeamsRepoImpl implements TeamsRepo {
  TeamsRepoImpl({required this.teamsApiService});

  static const int pendingJoinRequestStatus = 1;

  final TeamsApiService teamsApiService;

  @override
  Future<ApiResult<List<TeamSummaryModel>>> getMyTeams() async {
    try {
      return ApiResult.success(await teamsApiService.getMyTeams());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamDiscoveryPageModel>> discoverTeams({
    String? search,
    String? governorate,
    bool? isRecruiting,
    bool? isOpenForChallenges,
    int page = 1,
  }) async {
    try {
      return ApiResult.success(
        await teamsApiService.discoverTeams(
          search: search,
          governorate: governorate,
          isRecruiting: isRecruiting,
          isOpenForChallenges: isOpenForChallenges,
          page: page,
        ),
      );
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamDetailModel>> getTeam(String teamId) async {
    try {
      return ApiResult.success(await teamsApiService.getTeam(teamId));
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamProfileModel>> getTeamProfile(String teamId) async {
    try {
      return ApiResult.success(await teamsApiService.getTeamProfile(teamId));
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamDetailModel>> createTeam(
    CreateTeamRequestBody body,
  ) async {
    try {
      return ApiResult.success(await teamsApiService.createTeam(body));
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamDetailModel>> acceptInvitation(String inviteCode) async {
    try {
      return ApiResult.success(
        await teamsApiService.acceptInvitation(
          AcceptTeamInvitationRequestBody(inviteCode: inviteCode),
        ),
      );
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamInvitePreviewModel>> previewInvitation(
    String code,
  ) async {
    try {
      return ApiResult.success(await teamsApiService.previewInvitation(code));
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamInvitationModel>> createInvitation(String teamId) async {
    try {
      return ApiResult.success(
        await teamsApiService.createInvitation(
          teamId,
          const CreateTeamInvitationRequestBody(validityDays: 7),
        ),
      );
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamJoinRequestModel>> requestToJoin(
    String teamId, {
    String? message,
  }) async {
    try {
      return ApiResult.success(
        await teamsApiService.requestToJoin(
          teamId,
          JoinTeamRequestBody(message: message),
        ),
      );
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<List<TeamJoinRequestModel>>> getPendingJoinRequests(
    String teamId,
  ) async {
    try {
      return ApiResult.success(
        await teamsApiService.getJoinRequests(
          teamId,
          status: pendingJoinRequestStatus,
        ),
      );
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> approveJoinRequest(
    String teamId,
    String requestId,
  ) async {
    try {
      await teamsApiService.approveJoinRequest(teamId, requestId);
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> declineJoinRequest(
    String teamId,
    String requestId,
  ) async {
    try {
      await teamsApiService.declineJoinRequest(teamId, requestId);
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> leaveTeam(String teamId) async {
    try {
      await teamsApiService.leaveTeam(teamId);
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> removeMember(String teamId, String playerId) async {
    try {
      await teamsApiService.removeMember(teamId, playerId);
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> updateSettings(
    String teamId,
    UpdateTeamSettingsRequestBody body,
  ) async {
    try {
      await teamsApiService.updateSettings(teamId, body);
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> updateMemberRole(
    String teamId,
    String playerId,
    int role,
  ) async {
    try {
      await teamsApiService.updateMemberRole(
        teamId,
        playerId,
        UpdateMemberRoleRequestBody(role: role),
      );
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> transferCaptaincy(
    String teamId,
    String newCaptainPlayerId,
  ) async {
    try {
      await teamsApiService.transferCaptaincy(
        teamId,
        TransferCaptaincyRequestBody(newCaptainPlayerId: newCaptainPlayerId),
      );
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamLeaderboardPageModel>> getLeaderboard({
    String? governorate,
    int page = 1,
  }) async {
    try {
      return ApiResult.success(
        await teamsApiService.getLeaderboard(
          governorate: governorate,
          page: page,
        ),
      );
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
