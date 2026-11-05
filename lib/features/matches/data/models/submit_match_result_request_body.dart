import 'package:json_annotation/json_annotation.dart';

part 'submit_match_result_request_body.g.dart';

@JsonSerializable()
class SubmitMatchResultRequestBody {
  const SubmitMatchResultRequestBody({
    required this.homeScore,
    required this.awayScore,
  });

  final int homeScore;
  final int awayScore;

  factory SubmitMatchResultRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SubmitMatchResultRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitMatchResultRequestBodyToJson(this);
}
