// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_consent_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordConsentRequestBody _$RecordConsentRequestBodyFromJson(
  Map<String, dynamic> json,
) => RecordConsentRequestBody(
  type: $enumDecode(_$ConsentTypeEnumMap, json['type']),
  granted: json['granted'] as bool,
);

Map<String, dynamic> _$RecordConsentRequestBodyToJson(
  RecordConsentRequestBody instance,
) => <String, dynamic>{
  'type': _$ConsentTypeEnumMap[instance.type]!,
  'granted': instance.granted,
};

const _$ConsentTypeEnumMap = {
  ConsentType.notifications: 2,
  ConsentType.location: 3,
  ConsentType.marketing: 4,
};
