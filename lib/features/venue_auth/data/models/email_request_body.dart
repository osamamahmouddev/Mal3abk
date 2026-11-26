import 'package:json_annotation/json_annotation.dart';

part 'email_request_body.g.dart';

@JsonSerializable(createFactory: false)
class EmailRequestBody {
  const EmailRequestBody({required this.email});

  final String email;

  Map<String, dynamic> toJson() => _$EmailRequestBodyToJson(this);
}
