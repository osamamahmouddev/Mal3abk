// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_booking_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueBookingDetailModel _$VenueBookingDetailModelFromJson(
  Map<String, dynamic> json,
) => VenueBookingDetailModel(
  id: json['id'] as String,
  reference: json['reference'] as String,
  pitchId: json['pitchId'] as String,
  startUtc: json['startUtc'] as String,
  endUtc: json['endUtc'] as String,
  status: (json['status'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
  depositAmount: (json['depositAmount'] as num?)?.toDouble() ?? 0,
  currency: json['currency'] as String? ?? 'EGP',
  holdExpiresAtUtc: json['holdExpiresAtUtc'] as String?,
  customerName: json['customerName'] as String?,
  customerPhone: json['customerPhone'] as String?,
  notes: json['notes'] as String?,
  statusHistory:
      (json['statusHistory'] as List<dynamic>?)
          ?.map(
            (e) => VenueStatusHistoryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  pitchName: json['pitchName'] as String?,
  platformCommission: (json['platformCommission'] as num?)?.toDouble() ?? 0,
  venueNetAmount: (json['venueNetAmount'] as num?)?.toDouble() ?? 0,
  venuePayAmount: (json['venuePayAmount'] as num?)?.toDouble() ?? 0,
  isCommissionPaid: json['isCommissionPaid'] as bool? ?? false,
  isManual: json['isManual'] as bool? ?? false,
);

VenueStatusHistoryModel _$VenueStatusHistoryModelFromJson(
  Map<String, dynamic> json,
) => VenueStatusHistoryModel(
  status: (json['status'] as num).toInt(),
  changedAtUtc: json['changedAtUtc'] as String,
  reason: json['reason'] as String?,
);
