import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request_body.g.dart';

@JsonSerializable()
class SendOtpRequestBody {
  const SendOtpRequestBody({
    required this.phoneNumber,
    required this.turnstileToken,
  });

  final String phoneNumber;
  final String turnstileToken;

  factory SendOtpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpRequestBodyToJson(this);
}
