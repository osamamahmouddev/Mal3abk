// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_quote_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingQuoteRequestBody _$BookingQuoteRequestBodyFromJson(
  Map<String, dynamic> json,
) => BookingQuoteRequestBody(
  pitchId: json['pitchId'] as String,
  startUtc: json['startUtc'] as String,
  endUtc: json['endUtc'] as String,
);

Map<String, dynamic> _$BookingQuoteRequestBodyToJson(
  BookingQuoteRequestBody instance,
) => <String, dynamic>{
  'pitchId': instance.pitchId,
  'startUtc': instance.startUtc,
  'endUtc': instance.endUtc,
};
