// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operating_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperatingScheduleModel _$OperatingScheduleModelFromJson(
  Map<String, dynamic> json,
) => OperatingScheduleModel(
  dayOfWeek: (json['dayOfWeek'] as num).toInt(),
  openTime: json['openTime'] as String,
  closeTime: json['closeTime'] as String,
  id: json['id'] as String?,
  slotDurationMinutes: (json['slotDurationMinutes'] as num?)?.toInt() ?? 60,
  isActive: json['isActive'] as bool? ?? true,
  isOvernight: json['isOvernight'] as bool? ?? false,
);

Map<String, dynamic> _$OperatingScheduleModelToJson(
  OperatingScheduleModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'dayOfWeek': instance.dayOfWeek,
  'openTime': instance.openTime,
  'closeTime': instance.closeTime,
  'slotDurationMinutes': instance.slotDurationMinutes,
  'isActive': instance.isActive,
  'isOvernight': instance.isOvernight,
};
