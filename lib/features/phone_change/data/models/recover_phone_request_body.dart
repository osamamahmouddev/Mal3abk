import 'package:json_annotation/json_annotation.dart';

part 'recover_phone_request_body.g.dart';

@JsonSerializable()
class RecoverPhoneRequestBody {
  const RecoverPhoneRequestBody({required this.recoveryToken});

  final String recoveryToken;

  factory RecoverPhoneRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RecoverPhoneRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RecoverPhoneRequestBodyToJson(this);
}
