import 'package:json_annotation/json_annotation.dart';

part 'language_request_body.g.dart';

@JsonSerializable()
class LanguageRequestBody {
  const LanguageRequestBody({required this.language});

  final String language;

  factory LanguageRequestBody.fromJson(Map<String, dynamic> json) =>
      _$LanguageRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageRequestBodyToJson(this);
}
