// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consents_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsentModel _$ConsentModelFromJson(Map<String, dynamic> json) => ConsentModel(
  type: json['type'] as String,
  granted: json['granted'] as bool,
  version: json['version'] as String?,
  recordedAtUtc: DateTime.parse(json['recordedAtUtc'] as String),
);

Map<String, dynamic> _$ConsentModelToJson(ConsentModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'granted': instance.granted,
      'version': instance.version,
      'recordedAtUtc': instance.recordedAtUtc.toIso8601String(),
    };

ConsentsModel _$ConsentsModelFromJson(Map<String, dynamic> json) =>
    ConsentsModel(
      current:
          (json['current'] as List<dynamic>?)
              ?.map((e) => ConsentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      history:
          (json['history'] as List<dynamic>?)
              ?.map((e) => ConsentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ConsentsModelToJson(ConsentsModel instance) =>
    <String, dynamic>{'current': instance.current, 'history': instance.history};
