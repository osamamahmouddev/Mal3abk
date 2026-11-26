import 'package:json_annotation/json_annotation.dart';

part 'owner_login_request_body.g.dart';

/// Venue owner/staff sign-in. [email] also takes the account's mobile number,
/// like the venue web sign-in.
@JsonSerializable(includeIfNull: false)
class OwnerLoginRequestBody {
  const OwnerLoginRequestBody({
    required this.email,
    required this.password,
    this.totpCode,
    this.turnstileToken,
  });

  final String email;
  final String password;
  final String? totpCode;
  final String? turnstileToken;

  factory OwnerLoginRequestBody.fromJson(Map<String, dynamic> json) =>
      _$OwnerLoginRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerLoginRequestBodyToJson(this);
}
