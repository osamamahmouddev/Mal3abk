import 'package:json_annotation/json_annotation.dart';

part 'step_up_response_model.g.dart';

@JsonSerializable()
class StepUpResponseModel {
  const StepUpResponseModel({
    required this.stepUpToken,
    required this.expiresInSeconds,
  });

  final String stepUpToken;
  final int expiresInSeconds;

  factory StepUpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StepUpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StepUpResponseModelToJson(this);
}
