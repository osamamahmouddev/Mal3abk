import 'team_detail_model.dart';

/// A team the server created. [settingsSaved] is false when the privacy and
/// recruiting switches could not be saved after creation, so the team kept
/// the server defaults (public, recruiting, open for challenges).
class CreatedTeamModel {
  const CreatedTeamModel({required this.team, required this.settingsSaved});

  final TeamDetailModel team;
  final bool settingsSaved;
}
