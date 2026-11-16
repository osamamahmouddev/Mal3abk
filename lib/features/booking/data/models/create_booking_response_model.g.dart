// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_booking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBookingResponseModel _$CreateBookingResponseModelFromJson(
  Map<String, dynamic> json,
) => CreateBookingResponseModel(
  bookingId: json['bookingId'] as String,
  bookingReference: json['bookingReference'] as String,
  venueId: json['venueId'] as String,
  pitchId: json['pitchId'] as String,
  startUtc: json['startUtc'] as String,
  endUtc: json['endUtc'] as String,
  totalPrice: (json['totalPrice'] as num).toDouble(),
  depositAmount: (json['depositAmount'] as num).toDouble(),
  currency: json['currency'] as String,
  status: $enumDecode(
    _$BookingStatusEnumMap,
    json['status'],
    unknownValue: BookingStatus.draft,
  ),
  holdExpiresAtUtc: json['holdExpiresAtUtc'] as String,
  paymentInstructions: json['paymentInstructions'] as String?,
  pitchName: json['pitchName'] as String?,
  venueName: json['venueName'] as String?,
  platformCommission: (json['platformCommission'] as num?)?.toDouble() ?? 0.0,
  venueNetAmount: (json['venueNetAmount'] as num?)?.toDouble() ?? 0.0,
  onlineDepositAmount: (json['onlineDepositAmount'] as num?)?.toDouble() ?? 0.0,
  venuePayAmount: (json['venuePayAmount'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$CreateBookingResponseModelToJson(
  CreateBookingResponseModel instance,
) => <String, dynamic>{
  'bookingId': instance.bookingId,
  'bookingReference': instance.bookingReference,
  'venueId': instance.venueId,
  'pitchId': instance.pitchId,
  'pitchName': instance.pitchName,
  'venueName': instance.venueName,
  'startUtc': instance.startUtc,
  'endUtc': instance.endUtc,
  'totalPrice': instance.totalPrice,
  'depositAmount': instance.depositAmount,
  'currency': instance.currency,
  'status': _$BookingStatusEnumMap[instance.status]!,
  'holdExpiresAtUtc': instance.holdExpiresAtUtc,
  'paymentInstructions': instance.paymentInstructions,
  'platformCommission': instance.platformCommission,
  'venueNetAmount': instance.venueNetAmount,
  'onlineDepositAmount': instance.onlineDepositAmount,
  'venuePayAmount': instance.venuePayAmount,
};

const _$BookingStatusEnumMap = {
  BookingStatus.draft: 1,
  BookingStatus.pendingDeposit: 2,
  BookingStatus.proofSubmitted: 3,
  BookingStatus.underReview: 4,
  BookingStatus.confirmed: 5,
  BookingStatus.rejected: 6,
  BookingStatus.expired: 7,
  BookingStatus.cancelled: 8,
  BookingStatus.completed: 9,
  BookingStatus.noShow: 10,
};
