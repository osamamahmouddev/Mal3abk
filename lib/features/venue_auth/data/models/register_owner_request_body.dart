import 'package:json_annotation/json_annotation.dart';

part 'register_owner_request_body.g.dart';

@JsonSerializable(createFactory: false)
class RegisterOwnerRequestBody {
  const RegisterOwnerRequestBody({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  Map<String, dynamic> toJson() => _$RegisterOwnerRequestBodyToJson(this);
}
