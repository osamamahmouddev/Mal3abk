// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpResponseModel _$VerifyOtpResponseModelFromJson(
  Map<String, dynamic> json,
) => VerifyOtpResponseModel(
  userId: json['userId'] as String,
  phoneNumber: json['phoneNumber'] as String,
  fullName: json['fullName'] as String,
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  isNewUser: json['isNewUser'] as bool,
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  expiresIn: (json['expiresIn'] as num?)?.toInt(),
);

Map<String, dynamic> _$VerifyOtpResponseModelToJson(
  VerifyOtpResponseModel instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'phoneNumber': instance.phoneNumber,
  'fullName': instance.fullName,
  'roles': instance.roles,
  'isNewUser': instance.isNewUser,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresIn': instance.expiresIn,
};
