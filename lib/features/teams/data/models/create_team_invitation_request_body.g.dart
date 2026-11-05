// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_team_invitation_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTeamInvitationRequestBody _$CreateTeamInvitationRequestBodyFromJson(
  Map<String, dynamic> json,
) => CreateTeamInvitationRequestBody(
  validityDays: (json['validityDays'] as num?)?.toInt(),
  invitedPlayerId: json['invitedPlayerId'] as String?,
);

Map<String, dynamic> _$CreateTeamInvitationRequestBodyToJson(
  CreateTeamInvitationRequestBody instance,
) => <String, dynamic>{
  'validityDays': instance.validityDays,
  'invitedPlayerId': instance.invitedPlayerId,
};
