import '../../../../core/network/api_result.dart';
import '../../../matches/data/models/match_details_model.dart';
import '../../../matches/data/models/match_model.dart';
import '../../../matches/data/models/team_challenge_model.dart';
import '../../../matches/domain/repos/matches_repo.dart';
import '../../../teams/domain/repos/teams_repo.dart';
import '../../data/models/home_team_activity_model.dart';

class GetHomeTeamActivityUseCase {
  GetHomeTeamActivityUseCase({
    required this.teamsRepo,
    required this.matchesRepo,
    this.clock = DateTime.now,
  });

  static const int maxTeams = 5;

  final TeamsRepo teamsRepo;
  final MatchesRepo matchesRepo;
  final DateTime Function() clock;

  Future<ApiResult<HomeTeamActivityModel>> call() async {
    final teamsResult = await teamsRepo.getMyTeams();
    return teamsResult.when(
      success: (allTeams) async {
        if (allTeams.isEmpty) {
          return const ApiResult.success(
            HomeTeamActivityModel(hasTeams: false),
          );
        }
        final teams = allTeams.take(maxTeams).toList(growable: false);
        final leaders = teams.where((t) => t.isLeader).toList(growable: false);
        final (matchPages, challengeLists) = await (
          Future.wait([
            for (final team in teams)
              matchesRepo.getUpcomingMatches(teamId: team.id),
          ]),
          Future.wait([
            for (final team in leaders) matchesRepo.getTeamChallenges(team.id),
          ]),
        ).wait;

        final nowUtc = clock().toUtc();
        final details = <String, MatchDetailsModel>{};
        for (final (i, page) in matchPages.indexed) {
          final team = teams[i];
          final matches = page.maybeWhen(
            success: (p) => p.items,
            orElse: () => const <MatchModel>[],
          );
          for (final match in matches) {
            final candidate = MatchDetailsModel(match: match, myTeam: team);
            final existing = details[match.id];
            if (existing == null || (!existing.canLead && candidate.canLead)) {
              details[match.id] = candidate;
            }
          }
        }

        final ordered = details.values.toList()
          ..sort(
            (a, b) =>
                a.match.scheduledStartUtc.compareTo(b.match.scheduledStartUtc),
          );
        final awaitingResult = ordered
            .where((d) => d.canVerifyResult || d.canSubmitResult(nowUtc))
            .firstOrNull;
        final next = ordered
            .where((d) => d.match.scheduledStartUtc.isAfter(nowUtc))
            .firstOrNull
            ?.match;

        final challenges =
            [
                for (final list in challengeLists)
                  ...list.maybeWhen(
                    success: (items) => items,
                    orElse: () => const <TeamChallengeModel>[],
                  ),
              ].where((c) => c.isOpen && c.isMyTurn).toList()
              ..sort((a, b) => a.proposedDateUtc.compareTo(b.proposedDateUtc));

        return ApiResult.success(
          HomeTeamActivityModel(
            hasTeams: true,
            challengeAwaitingReply: challenges.firstOrNull,
            matchAwaitingResult: awaitingResult,
            nextMatch: next,
          ),
        );
      },
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
