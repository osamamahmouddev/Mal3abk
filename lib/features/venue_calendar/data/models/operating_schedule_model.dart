import 'package:json_annotation/json_annotation.dart';

part 'operating_schedule_model.g.dart';

/// Opening hours for one weekday (`OperatingScheduleDto`). [dayOfWeek] is
/// .NET's: 0 = Sunday … 6 = Saturday.
@JsonSerializable()
class OperatingScheduleModel {
  const OperatingScheduleModel({
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    this.id,
    this.slotDurationMinutes = 60,
    this.isActive = true,
    this.isOvernight = false,
  });

  final String? id;
  final int dayOfWeek;

  /// `HH:mm:ss`.
  final String openTime;
  final String closeTime;
  final int slotDurationMinutes;
  final bool isActive;
  final bool isOvernight;

  int get openHour => int.tryParse(openTime.split(':').first) ?? 0;

  /// The closing hour counted from the opening day, so a late close
  /// (02:00) reads as 26.
  int get closeHourFromDayStart {
    final close = int.tryParse(closeTime.split(':').first) ?? 0;
    return isOvernight || close <= openHour ? close + 24 : close;
  }

  factory OperatingScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$OperatingScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$OperatingScheduleModelToJson(this);
}
