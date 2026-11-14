import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../data/models/create_team_request_body.dart';
import '../../data/models/created_team_model.dart';
import '../../data/models/update_team_settings_request_body.dart';
import '../repos/teams_repo.dart';

class CreateTeamUseCase {
  CreateTeamUseCase({required this.teamsRepo});

  static const int minNameLength = 3;
  static const int maxNameLength = 40;

  /// Tries to save the privacy choice this many times after creation.
  static const int settingsAttempts = 2;

  final TeamsRepo teamsRepo;

  Future<ApiResult<CreatedTeamModel>> call(
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
    final settings = UpdateTeamSettingsRequestBody(
      isPublic: isPublic,
      isRecruiting: true,
      isOpenForChallenges: isPublic,
    );
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
        isPublic: settings.isPublic,
        isRecruiting: settings.isRecruiting,
        isOpenForChallenges: settings.isOpenForChallenges,
      ),
    );
    return created.when(
      success: (team) async {
        // The server applies the choice at creation. Servers deployed before
        // that ignore it and create the team public, so the same switches
        // are saved again; that is tried twice, and a failure is reported
        // instead of leaving a "private" team public without a word. This
        // second call can go once production applies privacy at creation.
        var saved = false;
        for (var attempt = 0; attempt < settingsAttempts && !saved; attempt++) {
          final result = await teamsRepo.updateSettings(team.id, settings);
          saved = result is Success<void>;
        }
        return ApiResult.success(
          CreatedTeamModel(team: team, settingsSaved: saved),
        );
      },
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
