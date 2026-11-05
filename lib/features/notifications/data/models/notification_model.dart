import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.type,
    required this.category,
    required this.title,
    required this.body,
    this.deepLink,
    required this.isRead,
    required this.createdAtUtc,
  });

  final String id;
  final String type;
  final String category;
  final String title;
  final String body;
  final String? deepLink;
  final bool isRead;
  final DateTime createdAtUtc;

  NotificationModel markedRead() => NotificationModel(
    id: id,
    type: type,
    category: category,
    title: title,
    body: body,
    deepLink: deepLink,
    isRead: true,
    createdAtUtc: createdAtUtc,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
