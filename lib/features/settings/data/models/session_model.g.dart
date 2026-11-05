// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
  sessionId: json['sessionId'] as String,
  deviceName: json['deviceName'] as String?,
  ipAddress: json['ipAddress'] as String,
  userAgent: json['userAgent'] as String,
  createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
  lastActivityAtUtc: DateTime.parse(json['lastActivityAtUtc'] as String),
  isCurrent: json['isCurrent'] as bool,
);

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'deviceName': instance.deviceName,
      'ipAddress': instance.ipAddress,
      'userAgent': instance.userAgent,
      'createdAtUtc': instance.createdAtUtc.toIso8601String(),
      'lastActivityAtUtc': instance.lastActivityAtUtc.toIso8601String(),
      'isCurrent': instance.isCurrent,
    };
