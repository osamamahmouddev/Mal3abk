// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_schedule_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialSchedulesModel _$SpecialSchedulesModelFromJson(
  Map<String, dynamic> json,
) => SpecialSchedulesModel(
  exceptions:
      (json['exceptions'] as List<dynamic>?)
          ?.map(
            (e) => ScheduleOverrideModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  pitchHours:
      (json['pitchHours'] as List<dynamic>?)
          ?.map(
            (e) => PitchWeeklyHoursModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  rules:
      (json['rules'] as List<dynamic>?)
          ?.map((e) => BookingRulesModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

ScheduleOverrideModel _$ScheduleOverrideModelFromJson(
  Map<String, dynamic> json,
) => ScheduleOverrideModel(
  id: json['id'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  kind: json['kind'] as String,
  pitchId: json['pitchId'] as String?,
  fromTime: json['fromTime'] as String?,
  toTime: json['toTime'] as String?,
  reason: json['reason'] as String? ?? '',
);

PitchWeeklyHoursModel _$PitchWeeklyHoursModelFromJson(
  Map<String, dynamic> json,
) => PitchWeeklyHoursModel(
  pitchId: json['pitchId'] as String,
  dayOfWeek: (json['dayOfWeek'] as num).toInt(),
  openTime: json['openTime'] as String,
  closeTime: json['closeTime'] as String,
  isClosed: json['isClosed'] as bool? ?? false,
);

BookingRulesModel _$BookingRulesModelFromJson(Map<String, dynamic> json) =>
    BookingRulesModel(
      pitchId: json['pitchId'] as String?,
      minDurationMinutes: (json['minDurationMinutes'] as num?)?.toInt() ?? 60,
      maxDurationMinutes: (json['maxDurationMinutes'] as num?)?.toInt() ?? 120,
      incrementMinutes: (json['incrementMinutes'] as num?)?.toInt() ?? 30,
      minNoticeMinutes: (json['minNoticeMinutes'] as num?)?.toInt() ?? 60,
      maxAdvanceDays: (json['maxAdvanceDays'] as num?)?.toInt() ?? 14,
    );

Map<String, dynamic> _$BookingRulesModelToJson(BookingRulesModel instance) =>
    <String, dynamic>{
      'pitchId': instance.pitchId,
      'minDurationMinutes': instance.minDurationMinutes,
      'maxDurationMinutes': instance.maxDurationMinutes,
      'incrementMinutes': instance.incrementMinutes,
      'minNoticeMinutes': instance.minNoticeMinutes,
      'maxAdvanceDays': instance.maxAdvanceDays,
    };

UpcomingBookingRefModel _$UpcomingBookingRefModelFromJson(
  Map<String, dynamic> json,
) => UpcomingBookingRefModel(
  bookingId: json['bookingId'] as String,
  reference: json['reference'] as String,
  startUtc: json['startUtc'] as String,
  pitchId: json['pitchId'] as String? ?? '',
  status: json['status'] as String? ?? '',
);
