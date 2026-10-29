// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpResponseModel _$SendOtpResponseModelFromJson(
  Map<String, dynamic> json,
) => SendOtpResponseModel(
  normalizedPhoneNumber: json['normalizedPhoneNumber'] as String,
  expiresInSeconds: (json['expiresInSeconds'] as num).toInt(),
);

Map<String, dynamic> _$SendOtpResponseModelToJson(
  SendOtpResponseModel instance,
) => <String, dynamic>{
  'normalizedPhoneNumber': instance.normalizedPhoneNumber,
  'expiresInSeconds': instance.expiresInSeconds,
};
