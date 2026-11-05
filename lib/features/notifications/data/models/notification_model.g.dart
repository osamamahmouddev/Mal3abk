// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      deepLink: json['deepLink'] as String?,
      isRead: json['isRead'] as bool,
      createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'category': instance.category,
      'title': instance.title,
      'body': instance.body,
      'deepLink': instance.deepLink,
      'isRead': instance.isRead,
      'createdAtUtc': instance.createdAtUtc.toIso8601String(),
    };
