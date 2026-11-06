import 'package:json_annotation/json_annotation.dart';

part 'unread_count_model.g.dart';

@JsonSerializable()
class UnreadCountModel {
  const UnreadCountModel({required this.unreadCount});

  final int unreadCount;

  factory UnreadCountModel.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnreadCountModelToJson(this);
}
