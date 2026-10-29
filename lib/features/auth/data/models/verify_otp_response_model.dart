import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response_model.g.dart';

@JsonSerializable()
class VerifyOtpResponseModel {
  const VerifyOtpResponseModel({
    required this.userId,
    required this.phoneNumber,
    required this.fullName,
    required this.roles,
    required this.isNewUser,
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  final String userId;
  final String phoneNumber;
  final String fullName;
  final List<String> roles;
  final bool isNewUser;
  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpResponseModelToJson(this);
}
