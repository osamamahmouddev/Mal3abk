// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_team_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTeamRequestBody _$CreateTeamRequestBodyFromJson(
  Map<String, dynamic> json,
) => CreateTeamRequestBody(
  name: json['name'] as String,
  description: json['description'] as String?,
  city: json['city'] as String,
  governorate: json['governorate'] as String,
  district: json['district'] as String?,
  logoUrl: json['logoUrl'] as String?,
  isPublic: json['isPublic'] as bool?,
  isRecruiting: json['isRecruiting'] as bool?,
  isOpenForChallenges: json['isOpenForChallenges'] as bool?,
);

Map<String, dynamic> _$CreateTeamRequestBodyToJson(
  CreateTeamRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'city': instance.city,
  'governorate': instance.governorate,
  'district': instance.district,
  'logoUrl': instance.logoUrl,
  'isPublic': instance.isPublic,
  'isRecruiting': instance.isRecruiting,
  'isOpenForChallenges': instance.isOpenForChallenges,
};
