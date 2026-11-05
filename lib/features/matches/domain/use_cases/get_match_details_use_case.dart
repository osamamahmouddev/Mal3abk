import '../../../../core/network/api_result.dart';
import '../../../teams/data/models/team_summary_model.dart';
import '../../../teams/domain/repos/teams_repo.dart';
import '../../data/models/match_details_model.dart';
import '../repos/matches_repo.dart';

class GetMatchDetailsUseCase {
  GetMatchDetailsUseCase({required this.matchesRepo, required this.teamsRepo});

  final MatchesRepo matchesRepo;
  final TeamsRepo teamsRepo;

  Future<ApiResult<MatchDetailsModel>> call(String matchId) async {
    final (matchResult, myTeamsResult) = await (
      matchesRepo.getMatch(matchId),
      teamsRepo.getMyTeams(),
    ).wait;

    return matchResult.when(
      success: (match) {
        final myTeams = myTeamsResult.maybeWhen(
          success: (teams) => teams,
          orElse: () => const <TeamSummaryModel>[],
        );
        final mine = myTeams.where((t) => match.involves(t.id));
        final myTeam =
            mine.where((t) => t.isLeader).firstOrNull ?? mine.firstOrNull;
        return ApiResult.success(
          MatchDetailsModel(match: match, myTeam: myTeam),
        );
      },
      failure: (failure) => ApiResult.failure(failure),
    );
  }
}
