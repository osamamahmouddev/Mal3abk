import 'package:json_annotation/json_annotation.dart';

part 'respond_to_challenge_request_body.g.dart';

enum ChallengeResponseAction {
  @JsonValue(1)
  accept,
  @JsonValue(2)
  decline,
  @JsonValue(3)
  counterPropose,
}

@JsonSerializable(includeIfNull: false)
class RespondToChallengeRequestBody {
  const RespondToChallengeRequestBody({
    required this.respondingTeamId,
    required this.action,
    this.newProposedDateUtc,
    this.newDurationMinutes,
    this.declineReason,
  });

  final String respondingTeamId;
  final ChallengeResponseAction action;
  final DateTime? newProposedDateUtc;
  final int? newDurationMinutes;
  final String? declineReason;

  factory RespondToChallengeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RespondToChallengeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RespondToChallengeRequestBodyToJson(this);
}
