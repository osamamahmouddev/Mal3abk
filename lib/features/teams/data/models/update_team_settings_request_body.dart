import 'package:json_annotation/json_annotation.dart';

part 'update_team_settings_request_body.g.dart';

@JsonSerializable()
class UpdateTeamSettingsRequestBody {
  const UpdateTeamSettingsRequestBody({
    required this.isPublic,
    required this.isRecruiting,
    required this.isOpenForChallenges,
  });

  final bool isPublic;
  final bool isRecruiting;
  final bool isOpenForChallenges;

  factory UpdateTeamSettingsRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateTeamSettingsRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTeamSettingsRequestBodyToJson(this);
}
