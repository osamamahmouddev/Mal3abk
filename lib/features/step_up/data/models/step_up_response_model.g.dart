// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_up_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepUpResponseModel _$StepUpResponseModelFromJson(Map<String, dynamic> json) =>
    StepUpResponseModel(
      stepUpToken: json['stepUpToken'] as String,
      expiresInSeconds: (json['expiresInSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$StepUpResponseModelToJson(
  StepUpResponseModel instance,
) => <String, dynamic>{
  'stepUpToken': instance.stepUpToken,
  'expiresInSeconds': instance.expiresInSeconds,
};
