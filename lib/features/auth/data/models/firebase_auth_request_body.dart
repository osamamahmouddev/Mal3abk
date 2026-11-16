import 'package:json_annotation/json_annotation.dart';

part 'firebase_auth_request_body.g.dart';

@JsonSerializable()
class FirebaseAuthRequestBody {
  const FirebaseAuthRequestBody({
    required this.idToken,
    this.fullName,
    this.restoreAccount = false,
  });

  final String idToken;
  final String? fullName;
  final bool restoreAccount;

  factory FirebaseAuthRequestBody.fromJson(Map<String, dynamic> json) =>
      _$FirebaseAuthRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseAuthRequestBodyToJson(this);
}
