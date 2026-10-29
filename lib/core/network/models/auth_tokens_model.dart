import 'package:json_annotation/json_annotation.dart';

part 'auth_tokens_model.g.dart';

@JsonSerializable()
class AuthTokensModel {
  const AuthTokensModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokensModelToJson(this);
}
