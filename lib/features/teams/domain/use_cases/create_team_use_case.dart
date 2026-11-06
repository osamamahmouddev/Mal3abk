import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../data/models/create_team_request_body.dart';
import '../../data/models/team_detail_model.dart';
import '../../data/models/update_team_settings_request_body.dart';
import '../repos/teams_repo.dart';

class CreateTeamUseCase {
  CreateTeamUseCase({required this.teamsRepo});

  static const int minNameLength = 3;
  static const int maxNameLength = 40;

  final TeamsRepo teamsRepo;

  Future<ApiResult<TeamDetailModel>> call(
    CreateTeamRequestBody body, {
    required bool isPublic,
  }) async {
    final name = body.name.trim();
    if (name.length < minNameLength || name.length > maxNameLength) {
      return const ApiResult.failure(
        AppApiFailure(message: 'errors.teams.invalid_name'),
      );
    }
    if (body.governorate.trim().isEmpty || body.city.trim().isEmpty) {
      return const ApiResult.failure(
        AppApiFailure(message: 'errors.teams.invalid_location'),
      );
    }
    final created = await teamsRepo.createTeam(
      CreateTeamRequestBody(
        name: name,
        description: body.description?.trim().isEmpty ?? true
            ? null
            : body.description!.trim(),
        city: body.city,
        governorate: body.governorate,
        district: body.district,
        logoUrl: body.logoUrl,
      ),
    );
    return created.when(
      success: (team) async {
        await teamsRepo.updateSettings(
          team.id,
          UpdateTeamSettingsRequestBody(
            isPublic: isPublic,
            isRecruiting: true,
            isOpenForChallenges: isPublic,
          ),
        );
        return ApiResult.success(team);
      },
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
