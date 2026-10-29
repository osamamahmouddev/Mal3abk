import 'package:json_annotation/json_annotation.dart';

part 'step_up_request_body.g.dart';

@JsonSerializable()
class StepUpRequestBody {
  const StepUpRequestBody({required this.scope});

  /// The step-up token is bound to this scope; phone change uses
  /// `change_phone`.
  final String scope;

  factory StepUpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$StepUpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$StepUpRequestBodyToJson(this);
}
