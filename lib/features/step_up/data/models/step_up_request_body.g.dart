// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_up_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepUpRequestBody _$StepUpRequestBodyFromJson(Map<String, dynamic> json) =>
    StepUpRequestBody(
      scope: json['scope'] as String,
      secret: json['secret'] as String,
      method:
          $enumDecodeNullable(_$StepUpMethodEnumMap, json['method']) ??
          StepUpMethod.otp,
    );

Map<String, dynamic> _$StepUpRequestBodyToJson(StepUpRequestBody instance) =>
    <String, dynamic>{
      'scope': instance.scope,
      'method': _$StepUpMethodEnumMap[instance.method]!,
      'secret': instance.secret,
    };

const _$StepUpMethodEnumMap = {
  StepUpMethod.password: 0,
  StepUpMethod.totp: 1,
  StepUpMethod.otp: 2,
};
