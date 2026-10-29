import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request_body.g.dart';

@JsonSerializable(includeIfNull: false)
class VerifyOtpRequestBody {
  const VerifyOtpRequestBody({
    required this.phoneNumber,
    required this.code,
    this.fullName,
  });

  final String phoneNumber;
  final String code;
  final String? fullName;

  factory VerifyOtpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestBodyToJson(this);
}
