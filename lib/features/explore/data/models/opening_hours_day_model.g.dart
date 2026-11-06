// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningWindowModel _$OpeningWindowModelFromJson(Map<String, dynamic> json) =>
    OpeningWindowModel(
      open: json['open'] as String,
      close: json['close'] as String,
    );

Map<String, dynamic> _$OpeningWindowModelToJson(OpeningWindowModel instance) =>
    <String, dynamic>{'open': instance.open, 'close': instance.close};

OpeningHoursDayModel _$OpeningHoursDayModelFromJson(
  Map<String, dynamic> json,
) => OpeningHoursDayModel(
  day: (json['day'] as num).toInt(),
  closed: json['closed'] as bool,
  windows: (json['windows'] as List<dynamic>)
      .map((e) => OpeningWindowModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OpeningHoursDayModelToJson(
  OpeningHoursDayModel instance,
) => <String, dynamic>{
  'day': instance.day,
  'closed': instance.closed,
  'windows': instance.windows,
};
