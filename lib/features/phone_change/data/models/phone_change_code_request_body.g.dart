// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_change_code_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneChangeCodeRequestBody _$PhoneChangeCodeRequestBodyFromJson(
  Map<String, dynamic> json,
) => PhoneChangeCodeRequestBody(
  requestId: json['requestId'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$PhoneChangeCodeRequestBodyToJson(
  PhoneChangeCodeRequestBody instance,
) => <String, dynamic>{'requestId': instance.requestId, 'code': instance.code};
