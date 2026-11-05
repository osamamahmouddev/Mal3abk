import 'package:json_annotation/json_annotation.dart';

part 'accept_team_invitation_request_body.g.dart';

@JsonSerializable()
class AcceptTeamInvitationRequestBody {
  const AcceptTeamInvitationRequestBody({required this.inviteCode});

  final String inviteCode;

  factory AcceptTeamInvitationRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AcceptTeamInvitationRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AcceptTeamInvitationRequestBodyToJson(this);
}
