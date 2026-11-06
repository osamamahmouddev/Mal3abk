import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/match_model.dart';
import '../models/match_page_model.dart';
import '../models/respond_to_challenge_request_body.dart';
import '../models/send_challenge_request_body.dart';
import '../models/submit_match_result_request_body.dart';
import '../models/team_challenge_model.dart';
import '../models/verify_match_result_request_body.dart';

part 'matches_api_service.g.dart';

@RestApi()
abstract class MatchesApiService {
  factory MatchesApiService(Dio dio, {String? baseUrl}) = _MatchesApiService;

  @POST(ApiConstants.challenges)
  Future<TeamChallengeModel> sendChallenge(
    @Body() SendChallengeRequestBody body,
  );

  @GET(ApiConstants.challengeDetails)
  Future<TeamChallengeModel> getChallenge(@Path('id') String challengeId);

  @POST(ApiConstants.respondToChallenge)
  Future<TeamChallengeModel> respondToChallenge(
    @Path('id') String challengeId,
    @Body() RespondToChallengeRequestBody body,
  );

  @GET(ApiConstants.teamChallenges)
  Future<List<TeamChallengeModel>> getTeamChallenges(@Path('id') String teamId);

  @GET(ApiConstants.upcomingMatches)
  Future<MatchPageModel> getUpcomingMatches({
    @Query('teamId') String? teamId,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
  });

  @GET(ApiConstants.matchHistory)
  Future<MatchPageModel> getMatchHistory({
    @Query('teamId') String? teamId,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
  });

  @GET(ApiConstants.matchDetails)
  Future<MatchModel> getMatch(@Path('id') String matchId);

  @POST(ApiConstants.matchResults)
  Future<MatchModel> submitResult(
    @Path('id') String matchId,
    @Query('teamId') String teamId,
    @Body() SubmitMatchResultRequestBody body,
  );

  @POST(ApiConstants.verifyMatchResult)
  Future<MatchModel> verifyResult(
    @Path('id') String matchId,
    @Query('teamId') String teamId,
    @Body() VerifyMatchResultRequestBody body,
  );
}
