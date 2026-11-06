import 'package:json_annotation/json_annotation.dart';

part 'notification_preference_model.g.dart';

@JsonSerializable()
class NotificationPreferenceModel {
  const NotificationPreferenceModel({
    required this.category,
    required this.inAppEnabled,
    required this.pushEnabled,
    required this.canDisable,
  });

  final String category;
  final bool inAppEnabled;
  final bool pushEnabled;
  final bool canDisable;

  factory NotificationPreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPreferenceModelToJson(this);
}
