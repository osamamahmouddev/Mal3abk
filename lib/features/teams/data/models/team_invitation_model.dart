import 'package:json_annotation/json_annotation.dart';

part 'team_invitation_model.g.dart';

@JsonSerializable()
class TeamInvitationModel {
  const TeamInvitationModel({
    required this.teamId,
    required this.inviteCode,
    this.expiresAtUtc,
  });

  final String teamId;
  final String inviteCode;
  final DateTime? expiresAtUtc;

  factory TeamInvitationModel.fromJson(Map<String, dynamic> json) =>
      _$TeamInvitationModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamInvitationModelToJson(this);
}
