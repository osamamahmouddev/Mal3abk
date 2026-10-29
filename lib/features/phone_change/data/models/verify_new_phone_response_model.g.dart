// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_new_phone_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyNewPhoneResponseModel _$VerifyNewPhoneResponseModelFromJson(
  Map<String, dynamic> json,
) => VerifyNewPhoneResponseModel(
  success: json['success'] as bool,
  newPhoneNumber: json['newPhoneNumber'] as String,
);

Map<String, dynamic> _$VerifyNewPhoneResponseModelToJson(
  VerifyNewPhoneResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'newPhoneNumber': instance.newPhoneNumber,
};
