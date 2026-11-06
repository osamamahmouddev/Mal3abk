import 'package:json_annotation/json_annotation.dart';

part 'create_team_request_body.g.dart';

@JsonSerializable()
class CreateTeamRequestBody {
  const CreateTeamRequestBody({
    required this.name,
    this.description,
    required this.city,
    required this.governorate,
    this.district,
    this.logoUrl,
  });

  final String name;
  final String? description;
  final String city;
  final String governorate;
  final String? district;
  final String? logoUrl;

  factory CreateTeamRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateTeamRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTeamRequestBodyToJson(this);
}
