// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_phone_change_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartPhoneChangeRequestBody _$StartPhoneChangeRequestBodyFromJson(
  Map<String, dynamic> json,
) => StartPhoneChangeRequestBody(
  newPhoneNumber: json['newPhoneNumber'] as String,
  stepUpToken: json['stepUpToken'] as String,
);

Map<String, dynamic> _$StartPhoneChangeRequestBodyToJson(
  StartPhoneChangeRequestBody instance,
) => <String, dynamic>{
  'newPhoneNumber': instance.newPhoneNumber,
  'stepUpToken': instance.stepUpToken,
};
