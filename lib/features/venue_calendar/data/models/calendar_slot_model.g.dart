// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarSlotModel _$CalendarSlotModelFromJson(Map<String, dynamic> json) =>
    CalendarSlotModel(
      id: json['id'] as String,
      pitchId: json['pitchId'] as String,
      startUtc: json['startUtc'] as String,
      endUtc: json['endUtc'] as String,
      status: json['status'] as String,
      customerName: json['customerName'] as String?,
      bookingReference: json['bookingReference'] as String? ?? '',
      isManual: json['isManual'] as bool? ?? false,
      reason: json['reason'] as String?,
      customerPhone: json['customerPhone'] as String?,
      depositAmount: (json['depositAmount'] as num?)?.toDouble() ?? 0,
      isTentative: json['isTentative'] as bool? ?? false,
    );
