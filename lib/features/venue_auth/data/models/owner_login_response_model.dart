import 'package:json_annotation/json_annotation.dart';

part 'owner_login_response_model.g.dart';

@JsonSerializable(createToJson: false)
class OwnerLoginResponseModel {
  const OwnerLoginResponseModel({
    required this.userId,
    required this.fullName,
    required this.roles,
    required this.accessToken,
    required this.refreshToken,
  });

  final String userId;
  final String fullName;
  final List<String> roles;
  final String accessToken;
  final String refreshToken;

  factory OwnerLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerLoginResponseModelFromJson(json);
}
