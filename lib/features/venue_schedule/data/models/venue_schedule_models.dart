import 'package:json_annotation/json_annotation.dart';

part 'venue_schedule_models.g.dart';

/// Closures, per-pitch hours and booking rules of a venue
/// (`SpecialSchedulesDto`).
@JsonSerializable(createToJson: false)
class SpecialSchedulesModel {
  const SpecialSchedulesModel({
    this.exceptions = const [],
    this.pitchHours = const [],
    this.rules = const [],
  });

  final List<ScheduleOverrideModel> exceptions;
  final List<PitchWeeklyHoursModel> pitchHours;
  final List<BookingRulesModel> rules;

  factory SpecialSchedulesModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialSchedulesModelFromJson(json);
}

/// A closed day, special hours or a break (`ScheduleOverrideDto`).
@JsonSerializable(createToJson: false)
class ScheduleOverrideModel {
  const ScheduleOverrideModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.kind,
    this.pitchId,
    this.fromTime,
    this.toTime,
    this.reason = '',
  });

  final String id;
  final String? pitchId;
  final String startDate;
  final String endDate;

  /// `Closure`, `SpecialHours` or `Break`.
  final String kind;
  final String? fromTime;
  final String? toTime;
  final String reason;

  factory ScheduleOverrideModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleOverrideModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class PitchWeeklyHoursModel {
  const PitchWeeklyHoursModel({
    required this.pitchId,
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    this.isClosed = false,
  });

  final String pitchId;
  final int dayOfWeek;
  final String openTime;
  final String closeTime;
  final bool isClosed;

  factory PitchWeeklyHoursModel.fromJson(Map<String, dynamic> json) =>
      _$PitchWeeklyHoursModelFromJson(json);
}

@JsonSerializable()
class BookingRulesModel {
  const BookingRulesModel({
    this.pitchId,
    this.minDurationMinutes = 60,
    this.maxDurationMinutes = 120,
    this.incrementMinutes = 30,
    this.minNoticeMinutes = 60,
    this.maxAdvanceDays = 14,
  });

  final String? pitchId;
  final int minDurationMinutes;
  final int maxDurationMinutes;
  final int incrementMinutes;
  final int minNoticeMinutes;
  final int maxAdvanceDays;

  BookingRulesModel copyWith({
    int? minDurationMinutes,
    int? maxDurationMinutes,
    int? incrementMinutes,
    int? minNoticeMinutes,
    int? maxAdvanceDays,
  }) => BookingRulesModel(
    pitchId: pitchId,
    minDurationMinutes: minDurationMinutes ?? this.minDurationMinutes,
    maxDurationMinutes: maxDurationMinutes ?? this.maxDurationMinutes,
    incrementMinutes: incrementMinutes ?? this.incrementMinutes,
    minNoticeMinutes: minNoticeMinutes ?? this.minNoticeMinutes,
    maxAdvanceDays: maxAdvanceDays ?? this.maxAdvanceDays,
  );

  factory BookingRulesModel.fromJson(Map<String, dynamic> json) =>
      _$BookingRulesModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingRulesModelToJson(this);
}

/// A confirmed booking a schedule change would leave outside the hours.
@JsonSerializable(createToJson: false)
class UpcomingBookingRefModel {
  const UpcomingBookingRefModel({
    required this.bookingId,
    required this.reference,
    required this.startUtc,
    this.pitchId = '',
    this.status = '',
  });

  final String bookingId;
  final String reference;
  final String pitchId;
  final String startUtc;
  final String status;

  factory UpcomingBookingRefModel.fromJson(Map<String, dynamic> json) =>
      _$UpcomingBookingRefModelFromJson(json);
}

/// A schedule change: applied, or held back because it hits bookings (the
/// API answers 409 until it is sent again with `confirm`).
class ScheduleChangeResult {
  const ScheduleChangeResult({required this.applied, this.affected = const []});

  final bool applied;
  final List<UpcomingBookingRefModel> affected;
}

/// `ScheduleOverrideKind` on the API.
enum ScheduleOverrideKind { closure, specialHours, breakTime }
