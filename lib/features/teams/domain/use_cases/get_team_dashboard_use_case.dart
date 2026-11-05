import '../../../../core/network/api_result.dart';
import '../../data/models/team_dashboard_model.dart';
import '../repos/teams_repo.dart';

class GetTeamDashboardUseCase {
  GetTeamDashboardUseCase({required this.teamsRepo});

  final TeamsRepo teamsRepo;

  Future<ApiResult<TeamDashboardModel>> call(String teamId) async {
    final profileResult = await teamsRepo.getTeamProfile(teamId);
    return profileResult.when(
      success: (profile) async {
        if (!profile.isCaptain) {
          return ApiResult.success(TeamDashboardModel(profile: profile));
        }
        final requests = await teamsRepo.getPendingJoinRequests(teamId);
        return requests.when(
          success: (pending) => ApiResult.success(
            TeamDashboardModel(profile: profile, pendingJoinRequests: pending),
          ),
          failure: (_) =>
              ApiResult.success(TeamDashboardModel(profile: profile)),
        );
      },
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
