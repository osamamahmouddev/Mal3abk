// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpRequestBody _$VerifyOtpRequestBodyFromJson(
  Map<String, dynamic> json,
) => VerifyOtpRequestBody(
  phoneNumber: json['phoneNumber'] as String,
  code: json['code'] as String,
  fullName: json['fullName'] as String?,
  restoreAccount: json['restoreAccount'] as bool?,
);

Map<String, dynamic> _$VerifyOtpRequestBodyToJson(
  VerifyOtpRequestBody instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'code': instance.code,
  'fullName': ?instance.fullName,
  'restoreAccount': ?instance.restoreAccount,
};
