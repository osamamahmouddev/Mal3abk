// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_phone_change_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartPhoneChangeResponseModel _$StartPhoneChangeResponseModelFromJson(
  Map<String, dynamic> json,
) => StartPhoneChangeResponseModel(
  requestId: json['requestId'] as String,
  expiresAtUtc: DateTime.parse(json['expiresAtUtc'] as String),
);

Map<String, dynamic> _$StartPhoneChangeResponseModelToJson(
  StartPhoneChangeResponseModel instance,
) => <String, dynamic>{
  'requestId': instance.requestId,
  'expiresAtUtc': instance.expiresAtUtc.toIso8601String(),
};
