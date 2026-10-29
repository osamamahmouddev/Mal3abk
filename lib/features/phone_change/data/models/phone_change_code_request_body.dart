import 'package:json_annotation/json_annotation.dart';

part 'phone_change_code_request_body.g.dart';

@JsonSerializable()
class PhoneChangeCodeRequestBody {
  const PhoneChangeCodeRequestBody({
    required this.requestId,
    required this.code,
  });

  final String requestId;
  final String code;

  factory PhoneChangeCodeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PhoneChangeCodeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneChangeCodeRequestBodyToJson(this);
}
