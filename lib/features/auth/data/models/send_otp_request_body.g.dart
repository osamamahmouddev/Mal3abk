// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpRequestBody _$SendOtpRequestBodyFromJson(Map<String, dynamic> json) =>
    SendOtpRequestBody(
      phoneNumber: json['phoneNumber'] as String,
      turnstileToken: json['turnstileToken'] as String,
    );

Map<String, dynamic> _$SendOtpRequestBodyToJson(SendOtpRequestBody instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'turnstileToken': instance.turnstileToken,
    };
