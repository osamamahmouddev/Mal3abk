// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_booking_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBookingRequestBody _$CreateBookingRequestBodyFromJson(
  Map<String, dynamic> json,
) => CreateBookingRequestBody(
  pitchId: json['pitchId'] as String,
  startUtc: json['startUtc'] as String,
  endUtc: json['endUtc'] as String,
  quoteToken: json['quoteToken'] as String,
  expectedPrice: (json['expectedPrice'] as num).toDouble(),
  customerName: json['customerName'] as String?,
  customerPhone: json['customerPhone'] as String?,
);

Map<String, dynamic> _$CreateBookingRequestBodyToJson(
  CreateBookingRequestBody instance,
) => <String, dynamic>{
  'pitchId': instance.pitchId,
  'startUtc': instance.startUtc,
  'endUtc': instance.endUtc,
  'quoteToken': instance.quoteToken,
  'expectedPrice': instance.expectedPrice,
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
};
