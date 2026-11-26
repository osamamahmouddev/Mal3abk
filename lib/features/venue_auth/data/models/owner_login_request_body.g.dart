// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_login_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerLoginRequestBody _$OwnerLoginRequestBodyFromJson(
  Map<String, dynamic> json,
) => OwnerLoginRequestBody(
  email: json['email'] as String,
  password: json['password'] as String,
  totpCode: json['totpCode'] as String?,
  turnstileToken: json['turnstileToken'] as String?,
);

Map<String, dynamic> _$OwnerLoginRequestBodyToJson(
  OwnerLoginRequestBody instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'totpCode': ?instance.totpCode,
  'turnstileToken': ?instance.turnstileToken,
};
