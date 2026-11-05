import '../../../../core/network/api_result.dart';
import '../../../teams/data/models/team_summary_model.dart';
import '../../../teams/domain/repos/teams_repo.dart';
import '../../data/models/challenge_details_model.dart';
import '../repos/matches_repo.dart';

class GetChallengeDetailsUseCase {
  GetChallengeDetailsUseCase({
    required this.matchesRepo,
    required this.teamsRepo,
  });

  final MatchesRepo matchesRepo;
  final TeamsRepo teamsRepo;

  Future<ApiResult<ChallengeDetailsModel>> call(String challengeId) async {
    final (challengeResult, myTeamsResult) = await (
      matchesRepo.getChallenge(challengeId),
      teamsRepo.getMyTeams(),
    ).wait;

    return challengeResult.when(
      success: (challenge) {
        final myTeams = myTeamsResult.maybeWhen(
          success: (teams) => teams,
          orElse: () => const <TeamSummaryModel>[],
        );
        final turnTeam = myTeams
            .where((t) => t.id == challenge.currentTurnTeamId)
            .firstOrNull;
        final myTeam =
            turnTeam ??
            myTeams
                .where(
                  (t) =>
                      t.id == challenge.challengerTeamId ||
                      t.id == challenge.challengedTeamId,
                )
                .firstOrNull;
        return ApiResult.success(
          ChallengeDetailsModel(challenge: challenge, myTeam: myTeam),
        );
      },
      failure: (failure) => ApiResult.failure(failure),
    );
  }
}
