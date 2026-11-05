// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_team_settings_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTeamSettingsRequestBody _$UpdateTeamSettingsRequestBodyFromJson(
  Map<String, dynamic> json,
) => UpdateTeamSettingsRequestBody(
  isPublic: json['isPublic'] as bool,
  isRecruiting: json['isRecruiting'] as bool,
  isOpenForChallenges: json['isOpenForChallenges'] as bool,
);

Map<String, dynamic> _$UpdateTeamSettingsRequestBodyToJson(
  UpdateTeamSettingsRequestBody instance,
) => <String, dynamic>{
  'isPublic': instance.isPublic,
  'isRecruiting': instance.isRecruiting,
  'isOpenForChallenges': instance.isOpenForChallenges,
};
