import 'package:json_annotation/json_annotation.dart';

part 'record_consent_request_body.g.dart';

/// Consent kinds the player can change from settings; terms and privacy are
/// accepted at sign-up.
enum ConsentType {
  @JsonValue(2)
  notifications('Notifications'),
  @JsonValue(3)
  location('Location'),
  @JsonValue(4)
  marketing('Marketing');

  const ConsentType(this.serverName);

  final String serverName;
}

@JsonSerializable()
class RecordConsentRequestBody {
  const RecordConsentRequestBody({required this.type, required this.granted});

  final ConsentType type;
  final bool granted;

  factory RecordConsentRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RecordConsentRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RecordConsentRequestBodyToJson(this);
}
