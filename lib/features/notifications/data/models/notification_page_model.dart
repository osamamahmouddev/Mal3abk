import 'package:json_annotation/json_annotation.dart';

import 'notification_model.dart';

part 'notification_page_model.g.dart';

@JsonSerializable()
class NotificationPageModel {
  const NotificationPageModel({
    this.items = const [],
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.unreadCount,
  });

  final List<NotificationModel> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final int unreadCount;

  bool get hasMore => page * pageSize < totalCount;

  factory NotificationPageModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPageModelToJson(this);
}
