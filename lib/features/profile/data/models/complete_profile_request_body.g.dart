// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_profile_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteProfileRequestBody _$CompleteProfileRequestBodyFromJson(
  Map<String, dynamic> json,
) => CompleteProfileRequestBody(
  fullName: json['fullName'] as String,
  city: json['city'] as String,
  area: json['area'] as String,
  positions:
      (json['positions'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PlayerPositionEnumMap, e))
          .toList() ??
      const [],
  skillLevel: $enumDecodeNullable(_$SkillLevelEnumMap, json['skillLevel']),
  language: json['language'] as String?,
);

Map<String, dynamic> _$CompleteProfileRequestBodyToJson(
  CompleteProfileRequestBody instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'city': instance.city,
  'area': instance.area,
  'positions': instance.positions
      .map((e) => _$PlayerPositionEnumMap[e]!)
      .toList(),
  'skillLevel': ?_$SkillLevelEnumMap[instance.skillLevel],
  'language': ?instance.language,
};

const _$PlayerPositionEnumMap = {
  PlayerPosition.goalkeeper: 0,
  PlayerPosition.defender: 1,
  PlayerPosition.midfielder: 2,
  PlayerPosition.forward: 3,
};

const _$SkillLevelEnumMap = {
  SkillLevel.beginner: 0,
  SkillLevel.intermediate: 1,
  SkillLevel.advanced: 2,
};
