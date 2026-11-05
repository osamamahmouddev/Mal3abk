import 'package:json_annotation/json_annotation.dart';

part 'verify_match_result_request_body.g.dart';

enum MatchVerificationAction {
  @JsonValue(1)
  confirm,
  @JsonValue(2)
  dispute,
}

@JsonSerializable(includeIfNull: false)
class VerifyMatchResultRequestBody {
  const VerifyMatchResultRequestBody({
    required this.action,
    this.disputeReason,
  });

  final MatchVerificationAction action;
  final String? disputeReason;

  factory VerifyMatchResultRequestBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyMatchResultRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyMatchResultRequestBodyToJson(this);
}
