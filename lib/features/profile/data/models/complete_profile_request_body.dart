import 'package:json_annotation/json_annotation.dart';

import 'player_attributes.dart';

part 'complete_profile_request_body.g.dart';

@JsonSerializable(includeIfNull: false)
class CompleteProfileRequestBody {
  const CompleteProfileRequestBody({
    required this.fullName,
    required this.city,
    required this.area,
    this.positions = const [],
    this.skillLevel,
    this.language,
  });

  final String fullName;
  final String city;
  final String area;
  final List<PlayerPosition> positions;
  final SkillLevel? skillLevel;
  final String? language;

  factory CompleteProfileRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteProfileRequestBodyToJson(this);
}
