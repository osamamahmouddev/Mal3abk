import 'package:json_annotation/json_annotation.dart';

part 'join_team_request_body.g.dart';

@JsonSerializable()
class JoinTeamRequestBody {
  const JoinTeamRequestBody({this.message});

  final String? message;

  factory JoinTeamRequestBody.fromJson(Map<String, dynamic> json) =>
      _$JoinTeamRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$JoinTeamRequestBodyToJson(this);
}
