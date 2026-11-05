import 'package:json_annotation/json_annotation.dart';

part 'step_up_request_body.g.dart';

enum StepUpMethod {
  @JsonValue(0)
  password,
  @JsonValue(1)
  totp,
  @JsonValue(2)
  otp,
}

@JsonSerializable()
class StepUpRequestBody {
  const StepUpRequestBody({
    required this.scope,
    required this.secret,
    this.method = StepUpMethod.otp,
  });

  final String scope;
  final StepUpMethod method;
  final String secret;

  factory StepUpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$StepUpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$StepUpRequestBodyToJson(this);
}
