import 'package:json_annotation/json_annotation.dart';

part 'send_challenge_request_body.g.dart';

@JsonSerializable(includeIfNull: false)
class SendChallengeRequestBody {
  const SendChallengeRequestBody({
    required this.challengerTeamId,
    required this.challengedTeamId,
    required this.proposedDateUtc,
    required this.durationMinutes,
    this.proposedVenueName,
    this.notes,
  });

  final String challengerTeamId;
  final String challengedTeamId;
  final DateTime proposedDateUtc;
  final int durationMinutes;
  final String? proposedVenueName;
  final String? notes;

  factory SendChallengeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SendChallengeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SendChallengeRequestBodyToJson(this);
}
