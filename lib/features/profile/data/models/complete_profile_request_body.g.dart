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
  positions: (json['positions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  skillLevel: json['skillLevel'] as String?,
  language: json['language'] as String?,
);

Map<String, dynamic> _$CompleteProfileRequestBodyToJson(
  CompleteProfileRequestBody instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'city': instance.city,
  'area': instance.area,
  'positions': instance.positions,
  'skillLevel': instance.skillLevel,
  'language': instance.language,
};
