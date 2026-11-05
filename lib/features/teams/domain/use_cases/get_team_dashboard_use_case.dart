import '../../../../core/network/api_result.dart';
import '../../../matches/data/models/match_model.dart';
import '../../../matches/data/models/match_page_model.dart';
import '../../../matches/data/models/team_challenge_model.dart';
import '../../../matches/domain/repos/matches_repo.dart';
import '../../data/models/team_dashboard_model.dart';
import '../../data/models/team_join_request_model.dart';
import '../repos/teams_repo.dart';

/// Loads a team profile with its matches; leaders also get open challenges and
/// the captain pending join requests. A failing extra still shows the profile.
class GetTeamDashboardUseCase {
  GetTeamDashboardUseCase({required this.teamsRepo, required this.matchesRepo});

  static const int recentMatchesCount = 5;

  final TeamsRepo teamsRepo;
  final MatchesRepo matchesRepo;

  Future<ApiResult<TeamDashboardModel>> call(String teamId) async {
    final profileResult = await teamsRepo.getTeamProfile(teamId);
    return profileResult.when(
      success: (profile) async {
        final (upcoming, recent, requests, challenges) = await (
          matchesRepo.getUpcomingMatches(teamId: teamId),
          matchesRepo.getMatchHistory(
            teamId: teamId,
            pageSize: recentMatchesCount,
          ),
          profile.isCaptain
              ? teamsRepo.getPendingJoinRequests(teamId)
              : Future.value(
                  const ApiResult<List<TeamJoinRequestModel>>.success([]),
                ),
          profile.isLeader
              ? matchesRepo.getTeamChallenges(teamId)
              : Future.value(
                  const ApiResult<List<TeamChallengeModel>>.success([]),
                ),
        ).wait;

        List<MatchModel> items(ApiResult<MatchPageModel> page) =>
            page.maybeWhen(success: (p) => p.items, orElse: () => const []);

        return ApiResult.success(
          TeamDashboardModel(
            profile: profile,
            upcomingMatches: items(upcoming),
            recentMatches: items(recent),
            pendingJoinRequests: requests.maybeWhen(
              success: (pending) => pending,
              orElse: () => const [],
            ),
            openChallenges: challenges.maybeWhen(
              success: (all) =>
                  all.where((c) => c.isOpen).toList(growable: false),
              orElse: () => const [],
            ),
          ),
        );
      },
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
