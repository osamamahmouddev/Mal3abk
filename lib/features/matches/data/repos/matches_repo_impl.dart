import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/matches_repo.dart';
import '../apis/matches_api_service.dart';
import '../models/match_model.dart';
import '../models/match_page_model.dart';
import '../models/respond_to_challenge_request_body.dart';
import '../models/send_challenge_request_body.dart';
import '../models/submit_match_result_request_body.dart';
import '../models/team_challenge_model.dart';
import '../models/verify_match_result_request_body.dart';

class MatchesRepoImpl implements MatchesRepo {
  MatchesRepoImpl({required this.matchesApiService});

  final MatchesApiService matchesApiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<TeamChallengeModel>> sendChallenge(
    SendChallengeRequestBody body,
  ) => _guard(() => matchesApiService.sendChallenge(body));

  @override
  Future<ApiResult<TeamChallengeModel>> getChallenge(String challengeId) =>
      _guard(() => matchesApiService.getChallenge(challengeId));

  @override
  Future<ApiResult<TeamChallengeModel>> respondToChallenge(
    String challengeId,
    RespondToChallengeRequestBody body,
  ) => _guard(() => matchesApiService.respondToChallenge(challengeId, body));

  @override
  Future<ApiResult<List<TeamChallengeModel>>> getTeamChallenges(
    String teamId,
  ) => _guard(() => matchesApiService.getTeamChallenges(teamId));

  @override
  Future<ApiResult<MatchPageModel>> getUpcomingMatches({String? teamId}) =>
      _guard(() => matchesApiService.getUpcomingMatches(teamId: teamId));

  @override
  Future<ApiResult<MatchPageModel>> getMatchHistory({
    required String teamId,
    int pageSize = 20,
  }) => _guard(
    () => matchesApiService.getMatchHistory(teamId: teamId, pageSize: pageSize),
  );

  @override
  Future<ApiResult<MatchModel>> getMatch(String matchId) =>
      _guard(() => matchesApiService.getMatch(matchId));

  @override
  Future<ApiResult<MatchModel>> submitResult(
    String matchId, {
    required String teamId,
    required int homeScore,
    required int awayScore,
  }) => _guard(
    () => matchesApiService.submitResult(
      matchId,
      teamId,
      SubmitMatchResultRequestBody(homeScore: homeScore, awayScore: awayScore),
    ),
  );

  @override
  Future<ApiResult<MatchModel>> verifyResult(
    String matchId, {
    required String teamId,
    required MatchVerificationAction action,
    String? disputeReason,
  }) => _guard(
    () => matchesApiService.verifyResult(
      matchId,
      teamId,
      VerifyMatchResultRequestBody(
        action: action,
        disputeReason: disputeReason,
      ),
    ),
  );
}
