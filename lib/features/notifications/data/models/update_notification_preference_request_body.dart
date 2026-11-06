import 'package:json_annotation/json_annotation.dart';

part 'update_notification_preference_request_body.g.dart';

@JsonSerializable()
class UpdateNotificationPreferenceRequestBody {
  const UpdateNotificationPreferenceRequestBody({
    required this.inAppEnabled,
    required this.pushEnabled,
  });

  final bool inAppEnabled;
  final bool pushEnabled;

  factory UpdateNotificationPreferenceRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$UpdateNotificationPreferenceRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpdateNotificationPreferenceRequestBodyToJson(this);
}
