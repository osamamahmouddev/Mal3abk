import 'package:json_annotation/json_annotation.dart';

part 'complete_profile_request_body.g.dart';

@JsonSerializable()
class CompleteProfileRequestBody {
  const CompleteProfileRequestBody({
    required this.fullName,
    required this.city,
    required this.area,
    this.positions,
    this.skillLevel,
    this.language,
  });

  final String fullName;
  final String city;
  final String area;
  final List<String>? positions;
  final String? skillLevel;
  final String? language;

  factory CompleteProfileRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteProfileRequestBodyToJson(this);
}
