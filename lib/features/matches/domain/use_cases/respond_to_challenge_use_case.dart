import '../../../../core/network/api_result.dart';
import '../../data/models/respond_to_challenge_request_body.dart';
import '../../data/models/team_challenge_model.dart';
import '../repos/matches_repo.dart';
import 'challenge_schedule_rules.dart';

class RespondToChallengeUseCase {
  RespondToChallengeUseCase({
    required this.matchesRepo,
    this.clock = DateTime.now,
  });

  final MatchesRepo matchesRepo;
  final DateTime Function() clock;

  Future<ApiResult<TeamChallengeModel>> accept(
    String challengeId,
    String teamId,
  ) => matchesRepo.respondToChallenge(
    challengeId,
    RespondToChallengeRequestBody(
      respondingTeamId: teamId,
      action: ChallengeResponseAction.accept,
    ),
  );

  Future<ApiResult<TeamChallengeModel>> decline(
    String challengeId,
    String teamId,
  ) => matchesRepo.respondToChallenge(
    challengeId,
    RespondToChallengeRequestBody(
      respondingTeamId: teamId,
      action: ChallengeResponseAction.decline,
    ),
  );

  Future<ApiResult<TeamChallengeModel>> counterPropose(
    String challengeId,
    String teamId, {
    required DateTime proposedUtc,
    required int durationMinutes,
  }) async {
    final failure = ChallengeScheduleRules.check(
      proposedUtc: proposedUtc,
      durationMinutes: durationMinutes,
      nowUtc: clock().toUtc(),
    );
    if (failure != null) return ApiResult.failure(failure);

    return matchesRepo.respondToChallenge(
      challengeId,
      RespondToChallengeRequestBody(
        respondingTeamId: teamId,
        action: ChallengeResponseAction.counterPropose,
        newProposedDateUtc: proposedUtc.toUtc(),
        newDurationMinutes: durationMinutes,
      ),
    );
  }
}
