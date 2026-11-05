import 'package:json_annotation/json_annotation.dart';

part 'team_member_model.g.dart';

@JsonSerializable()
class TeamMemberModel {
  const TeamMemberModel({
    required this.id,
    required this.playerId,
    required this.role,
    this.jerseyNumber,
    this.position,
    required this.joinedAtUtc,
    this.playerName,
  });

  final String id;
  final String playerId;
  final int role;
  final int? jerseyNumber;
  final String? position;
  final DateTime joinedAtUtc;
  final String? playerName;

  bool get isCaptain => role == 1;

  bool get isViceCaptain => role == 2;

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamMemberModelToJson(this);
}
