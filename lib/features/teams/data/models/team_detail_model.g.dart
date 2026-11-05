// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamDetailModel _$TeamDetailModelFromJson(Map<String, dynamic> json) =>
    TeamDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      governorate: json['governorate'] as String,
      captainId: json['captainId'] as String,
      inviteCode: json['inviteCode'] as String?,
      inviteCodeExpiresAtUtc: json['inviteCodeExpiresAtUtc'] == null
          ? null
          : DateTime.parse(json['inviteCodeExpiresAtUtc'] as String),
    );

Map<String, dynamic> _$TeamDetailModelToJson(
  TeamDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'city': instance.city,
  'governorate': instance.governorate,
  'captainId': instance.captainId,
  'inviteCode': instance.inviteCode,
  'inviteCodeExpiresAtUtc': instance.inviteCodeExpiresAtUtc?.toIso8601String(),
};
