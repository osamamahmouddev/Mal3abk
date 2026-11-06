import 'package:json_annotation/json_annotation.dart';

part 'team_challenge_model.g.dart';

enum ChallengeStatus {
  @JsonValue(1)
  pending,
  @JsonValue(2)
  counterProposed,
  @JsonValue(3)
  accepted,
  @JsonValue(4)
  declined,
  @JsonValue(5)
  cancelled,
  @JsonValue(6)
  expired,
}

@JsonSerializable()
class TeamChallengeModel {
  const TeamChallengeModel({
    required this.id,
    required this.challengerTeamId,
    this.challengerTeamName,
    required this.challengedTeamId,
    this.challengedTeamName,
    required this.proposedDateUtc,
    required this.proposedDurationMinutes,
    this.proposedVenueName,
    this.notes,
    required this.status,
    required this.currentTurnTeamId,
    required this.isMyTurn,
    this.declinedReason,
    this.matchId,
  });

  final String id;
  final String challengerTeamId;
  final String? challengerTeamName;
  final String challengedTeamId;
  final String? challengedTeamName;
  final DateTime proposedDateUtc;
  final int proposedDurationMinutes;
  final String? proposedVenueName;
  final String? notes;
  final ChallengeStatus status;
  final String currentTurnTeamId;
  final bool isMyTurn;
  final String? declinedReason;
  final String? matchId;

  bool get isOpen =>
      status == ChallengeStatus.pending ||
      status == ChallengeStatus.counterProposed;

  String get waitingTeamName =>
      (currentTurnTeamId == challengerTeamId
          ? challengerTeamName
          : challengedTeamName) ??
      '';

  factory TeamChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$TeamChallengeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamChallengeModelToJson(this);
}
