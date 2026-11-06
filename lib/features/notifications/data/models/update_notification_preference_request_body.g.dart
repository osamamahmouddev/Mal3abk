// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_notification_preference_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNotificationPreferenceRequestBody
_$UpdateNotificationPreferenceRequestBodyFromJson(Map<String, dynamic> json) =>
    UpdateNotificationPreferenceRequestBody(
      inAppEnabled: json['inAppEnabled'] as bool,
      pushEnabled: json['pushEnabled'] as bool,
    );

Map<String, dynamic> _$UpdateNotificationPreferenceRequestBodyToJson(
  UpdateNotificationPreferenceRequestBody instance,
) => <String, dynamic>{
  'inAppEnabled': instance.inAppEnabled,
  'pushEnabled': instance.pushEnabled,
};
