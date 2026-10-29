import 'package:json_annotation/json_annotation.dart';

part 'send_otp_response_model.g.dart';

@JsonSerializable()
class SendOtpResponseModel {
  const SendOtpResponseModel({
    required this.normalizedPhoneNumber,
    required this.expiresInSeconds,
  });

  final String normalizedPhoneNumber;
  final int expiresInSeconds;

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpResponseModelToJson(this);
}
