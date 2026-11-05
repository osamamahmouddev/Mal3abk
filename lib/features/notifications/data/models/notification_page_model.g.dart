// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPageModel _$NotificationPageModelFromJson(
  Map<String, dynamic> json,
) => NotificationPageModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  unreadCount: (json['unreadCount'] as num).toInt(),
);

Map<String, dynamic> _$NotificationPageModelToJson(
  NotificationPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'page': instance.page,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'unreadCount': instance.unreadCount,
};
