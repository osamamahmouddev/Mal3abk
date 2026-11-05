// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_match_result_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyMatchResultRequestBody _$VerifyMatchResultRequestBodyFromJson(
  Map<String, dynamic> json,
) => VerifyMatchResultRequestBody(
  action: $enumDecode(_$MatchVerificationActionEnumMap, json['action']),
  disputeReason: json['disputeReason'] as String?,
);

Map<String, dynamic> _$VerifyMatchResultRequestBodyToJson(
  VerifyMatchResultRequestBody instance,
) => <String, dynamic>{
  'action': _$MatchVerificationActionEnumMap[instance.action]!,
  'disputeReason': ?instance.disputeReason,
};

const _$MatchVerificationActionEnumMap = {
  MatchVerificationAction.confirm: 1,
  MatchVerificationAction.dispute: 2,
};
