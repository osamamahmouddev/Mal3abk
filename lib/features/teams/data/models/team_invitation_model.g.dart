// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_invitation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamInvitationModel _$TeamInvitationModelFromJson(Map<String, dynamic> json) =>
    TeamInvitationModel(
      teamId: json['teamId'] as String,
      inviteCode: json['inviteCode'] as String,
      expiresAtUtc: json['expiresAtUtc'] == null
          ? null
          : DateTime.parse(json['expiresAtUtc'] as String),
    );

Map<String, dynamic> _$TeamInvitationModelToJson(
  TeamInvitationModel instance,
) => <String, dynamic>{
  'teamId': instance.teamId,
  'inviteCode': instance.inviteCode,
  'expiresAtUtc': instance.expiresAtUtc?.toIso8601String(),
};
