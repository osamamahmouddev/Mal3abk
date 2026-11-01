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
  status: json['status'],
  holdExpiresAtUtc: json['holdExpiresAtUtc'] as String,
  paymentInstructions: json['paymentInstructions'] as String?,
);

Map<String, dynamic> _$CreateBookingResponseModelToJson(
  CreateBookingResponseModel instance,
) => <String, dynamic>{
  'bookingId': instance.bookingId,
  'bookingReference': instance.bookingReference,
  'venueId': instance.venueId,
  'pitchId': instance.pitchId,
  'startUtc': instance.startUtc,
  'endUtc': instance.endUtc,
  'totalPrice': instance.totalPrice,
  'depositAmount': instance.depositAmount,
  'currency': instance.currency,
  'status': instance.status,
  'holdExpiresAtUtc': instance.holdExpiresAtUtc,
  'paymentInstructions': instance.paymentInstructions,
};
