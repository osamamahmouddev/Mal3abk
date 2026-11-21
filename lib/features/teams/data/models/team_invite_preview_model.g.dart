// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_invite_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamInvitePreviewModel _$TeamInvitePreviewModelFromJson(
  Map<String, dynamic> json,
) => TeamInvitePreviewModel(
  teamId: json['teamId'] as String,
  name: json['name'] as String,
  city: json['city'] as String,
  governorate: json['governorate'] as String,
  logoUrl: json['logoUrl'] as String?,
  district: json['district'] as String?,
  memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
  maxMembers: (json['maxMembers'] as num?)?.toInt() ?? 25,
  expiresAtUtc: json['expiresAtUtc'] == null
      ? null
      : DateTime.parse(json['expiresAtUtc'] as String),
  isAlreadyMember: json['isAlreadyMember'] as bool? ?? false,
);

Map<String, dynamic> _$TeamInvitePreviewModelToJson(
  TeamInvitePreviewModel instance,
) => <String, dynamic>{
  'teamId': instance.teamId,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
  'city': instance.city,
  'governorate': instance.governorate,
  'district': instance.district,
  'memberCount': instance.memberCount,
  'maxMembers': instance.maxMembers,
  'expiresAtUtc': instance.expiresAtUtc?.toIso8601String(),
  'isAlreadyMember': instance.isAlreadyMember,
};
