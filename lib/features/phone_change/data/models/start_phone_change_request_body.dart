import 'package:json_annotation/json_annotation.dart';

part 'start_phone_change_request_body.g.dart';

@JsonSerializable()
class StartPhoneChangeRequestBody {
  const StartPhoneChangeRequestBody({
    required this.newPhoneNumber,
    required this.stepUpToken,
  });

  final String newPhoneNumber;
  final String stepUpToken;

  factory StartPhoneChangeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$StartPhoneChangeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$StartPhoneChangeRequestBodyToJson(this);
}
