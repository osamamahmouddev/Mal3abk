import '../../../../core/network/api_result.dart';
import '../../data/models/match_model.dart';
import '../../data/models/match_page_model.dart';
import '../../data/models/respond_to_challenge_request_body.dart';
import '../../data/models/send_challenge_request_body.dart';
import '../../data/models/team_challenge_model.dart';
import '../../data/models/verify_match_result_request_body.dart';

abstract class MatchesRepo {
  Future<ApiResult<TeamChallengeModel>> sendChallenge(
    SendChallengeRequestBody body,
  );

  Future<ApiResult<TeamChallengeModel>> getChallenge(String challengeId);

  Future<ApiResult<TeamChallengeModel>> respondToChallenge(
    String challengeId,
    RespondToChallengeRequestBody body,
  );

  Future<ApiResult<List<TeamChallengeModel>>> getTeamChallenges(String teamId);

  Future<ApiResult<MatchPageModel>> getUpcomingMatches({String? teamId});

  Future<ApiResult<MatchPageModel>> getMatchHistory({
    required String teamId,
    int pageSize = 20,
  });

  Future<ApiResult<MatchModel>> getMatch(String matchId);

  Future<ApiResult<MatchModel>> submitResult(
    String matchId, {
    required String teamId,
    required int homeScore,
    required int awayScore,
  });

  Future<ApiResult<MatchModel>> verifyResult(
    String matchId, {
    required String teamId,
    required MatchVerificationAction action,
    String? disputeReason,
  });
}
