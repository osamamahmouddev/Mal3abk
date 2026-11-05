import '../../../../core/network/api_result.dart';
import '../../data/models/leaderboard_view_model.dart';
import '../repos/teams_repo.dart';

class GetLeaderboardUseCase {
  GetLeaderboardUseCase({required this.teamsRepo});

  final TeamsRepo teamsRepo;

  Future<ApiResult<LeaderboardViewModel>> call({
    String? governorate,
    int page = 1,
  }) async {
    final leaderboardFuture = teamsRepo.getLeaderboard(
      governorate: governorate,
      page: page,
    );
    final myTeamsFuture = teamsRepo.getMyTeams();
    final leaderboard = await leaderboardFuture;
    final myTeams = await myTeamsFuture;
    final myTeamIds = myTeams.maybeWhen(
      success: (teams) => {for (final team in teams) team.id},
      orElse: () => <String>{},
    );
    return leaderboard.when(
      success: (page) => ApiResult.success(
        LeaderboardViewModel(page: page, myTeamIds: myTeamIds),
      ),
      failure: ApiResult.failure,
    );
  }
}
