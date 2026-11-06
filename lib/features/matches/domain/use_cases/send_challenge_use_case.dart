import '../../../../core/network/api_result.dart';
import '../../data/models/send_challenge_request_body.dart';
import '../../data/models/team_challenge_model.dart';
import '../repos/matches_repo.dart';
import 'challenge_schedule_rules.dart';

class SendChallengeUseCase {
  SendChallengeUseCase({required this.matchesRepo, this.clock = DateTime.now});

  final MatchesRepo matchesRepo;
  final DateTime Function() clock;

  Future<ApiResult<TeamChallengeModel>> call(
    SendChallengeRequestBody body,
  ) async {
    final failure = ChallengeScheduleRules.check(
      proposedUtc: body.proposedDateUtc,
      durationMinutes: body.durationMinutes,
      nowUtc: clock().toUtc(),
    );
    if (failure != null) return ApiResult.failure(failure);

    final notes = body.notes?.trim();
    return matchesRepo.sendChallenge(
      SendChallengeRequestBody(
        challengerTeamId: body.challengerTeamId,
        challengedTeamId: body.challengedTeamId,
        proposedDateUtc: body.proposedDateUtc.toUtc(),
        durationMinutes: body.durationMinutes,
        notes: notes == null || notes.isEmpty ? null : notes,
      ),
    );
  }
}
