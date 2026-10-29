import 'package:json_annotation/json_annotation.dart';

part 'logout_request_body.g.dart';

@JsonSerializable()
class LogoutRequestBody {
  const LogoutRequestBody({required this.refreshToken});

  final String refreshToken;

  factory LogoutRequestBody.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutRequestBodyToJson(this);
}
