import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/accept_team_invitation_request_body.dart';
import '../models/create_team_invitation_request_body.dart';
import '../models/create_team_request_body.dart';
import '../models/join_team_request_body.dart';
import '../models/team_detail_model.dart';
import '../models/team_discovery_page_model.dart';
import '../models/team_invitation_model.dart';
import '../models/team_join_request_model.dart';
import '../models/team_leaderboard_page_model.dart';
import '../models/team_profile_model.dart';
import '../models/team_summary_model.dart';
import '../models/transfer_captaincy_request_body.dart';
import '../models/update_team_settings_request_body.dart';

part 'teams_api_service.g.dart';

@RestApi()
abstract class TeamsApiService {
  factory TeamsApiService(Dio dio, {String? baseUrl}) = _TeamsApiService;

  @GET(ApiConstants.myTeams)
  Future<List<TeamSummaryModel>> getMyTeams();

  @GET(ApiConstants.teams)
  Future<TeamDiscoveryPageModel> discoverTeams({
    @Query('search') String? search,
    @Query('governorate') String? governorate,
    @Query('isRecruiting') bool? isRecruiting,
    @Query('isOpenForChallenges') bool? isOpenForChallenges,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
  });

  @GET(ApiConstants.teamProfile)
  Future<TeamProfileModel> getTeamProfile(@Path('id') String teamId);

  @POST(ApiConstants.teams)
  Future<TeamDetailModel> createTeam(@Body() CreateTeamRequestBody body);

  @POST(ApiConstants.acceptTeamInvitation)
  Future<TeamDetailModel> acceptInvitation(
    @Body() AcceptTeamInvitationRequestBody body,
  );

  @POST(ApiConstants.teamInvitations)
  Future<TeamInvitationModel> createInvitation(
    @Path('id') String teamId,
    @Body() CreateTeamInvitationRequestBody body,
  );

  @POST(ApiConstants.teamJoinRequests)
  Future<TeamJoinRequestModel> requestToJoin(
    @Path('id') String teamId,
    @Body() JoinTeamRequestBody body,
  );

  @GET(ApiConstants.teamJoinRequests)
  Future<List<TeamJoinRequestModel>> getJoinRequests(
    @Path('id') String teamId, {
    @Query('status') int? status,
  });

  @POST(ApiConstants.approveJoinRequest)
  Future<void> approveJoinRequest(
    @Path('id') String teamId,
    @Path('requestId') String requestId,
  );

  @POST(ApiConstants.declineJoinRequest)
  Future<void> declineJoinRequest(
    @Path('id') String teamId,
    @Path('requestId') String requestId,
  );

  @POST(ApiConstants.leaveTeam)
  Future<void> leaveTeam(@Path('id') String teamId);

  @DELETE(ApiConstants.teamMember)
  Future<void> removeMember(
    @Path('id') String teamId,
    @Path('playerId') String playerId,
  );

  @PUT(ApiConstants.teamSettings)
  Future<void> updateSettings(
    @Path('id') String teamId,
    @Body() UpdateTeamSettingsRequestBody body,
  );

  @POST(ApiConstants.transferCaptaincy)
  Future<void> transferCaptaincy(
    @Path('id') String teamId,
    @Body() TransferCaptaincyRequestBody body,
  );

  @GET(ApiConstants.leaderboard)
  Future<TeamLeaderboardPageModel> getLeaderboard({
    @Query('governorate') String? governorate,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
  });
}
