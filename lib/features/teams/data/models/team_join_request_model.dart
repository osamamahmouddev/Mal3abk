import 'package:json_annotation/json_annotation.dart';

part 'team_join_request_model.g.dart';

@JsonSerializable()
class TeamJoinRequestModel {
  const TeamJoinRequestModel({
    required this.id,
    required this.teamId,
    required this.playerId,
    this.message,
    required this.status,
    required this.createdAtUtc,
    this.playerName,
  });

  final String id;
  final String teamId;
  final String playerId;
  final String? message;
  final int status;
  final DateTime createdAtUtc;
  final String? playerName;

  factory TeamJoinRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TeamJoinRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamJoinRequestModelToJson(this);
}
