// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPreferenceModel _$NotificationPreferenceModelFromJson(
  Map<String, dynamic> json,
) => NotificationPreferenceModel(
  category: json['category'] as String,
  inAppEnabled: json['inAppEnabled'] as bool,
  pushEnabled: json['pushEnabled'] as bool,
  canDisable: json['canDisable'] as bool,
);

Map<String, dynamic> _$NotificationPreferenceModelToJson(
  NotificationPreferenceModel instance,
) => <String, dynamic>{
  'category': instance.category,
  'inAppEnabled': instance.inAppEnabled,
  'pushEnabled': instance.pushEnabled,
  'canDisable': instance.canDisable,
};
