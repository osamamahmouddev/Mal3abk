import 'package:json_annotation/json_annotation.dart';

part 'create_team_invitation_request_body.g.dart';

@JsonSerializable()
class CreateTeamInvitationRequestBody {
  const CreateTeamInvitationRequestBody({
    this.validityDays,
    this.invitedPlayerId,
  });

  final int? validityDays;
  final String? invitedPlayerId;

  factory CreateTeamInvitationRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateTeamInvitationRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateTeamInvitationRequestBodyToJson(this);
}
