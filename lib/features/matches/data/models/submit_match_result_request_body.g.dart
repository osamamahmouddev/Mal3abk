// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_match_result_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitMatchResultRequestBody _$SubmitMatchResultRequestBodyFromJson(
  Map<String, dynamic> json,
) => SubmitMatchResultRequestBody(
  homeScore: (json['homeScore'] as num).toInt(),
  awayScore: (json['awayScore'] as num).toInt(),
);

Map<String, dynamic> _$SubmitMatchResultRequestBodyToJson(
  SubmitMatchResultRequestBody instance,
) => <String, dynamic>{
  'homeScore': instance.homeScore,
  'awayScore': instance.awayScore,
};
