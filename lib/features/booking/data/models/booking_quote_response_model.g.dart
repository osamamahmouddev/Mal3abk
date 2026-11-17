// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_quote_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingQuoteResponseModel _$BookingQuoteResponseModelFromJson(
  Map<String, dynamic> json,
) => BookingQuoteResponseModel(
  quoteToken: json['quoteToken'] as String,
  expiresAtUtc: json['expiresAtUtc'] as String,
  currency: json['currency'] as String,
  subtotal: (json['subtotal'] as num).toDouble(),
  discount: (json['discount'] as num).toDouble(),
  fees: (json['fees'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
  deposit: (json['deposit'] as num).toDouble(),
  remainingBalance: (json['remainingBalance'] as num).toDouble(),
  subjectToConfirmation: json['subjectToConfirmation'] as bool,
  confirmationNote: json['confirmationNote'] as String,
  policySummary:
      (json['policySummary'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  netPitchPrice: (json['netPitchPrice'] as num?)?.toDouble() ?? 0,
  platformCommission: (json['platformCommission'] as num?)?.toDouble() ?? 0,
  onlineDepositAmount: (json['onlineDepositAmount'] as num?)?.toDouble() ?? 0,
  venuePayAmount: (json['venuePayAmount'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$BookingQuoteResponseModelToJson(
  BookingQuoteResponseModel instance,
) => <String, dynamic>{
  'quoteToken': instance.quoteToken,
  'expiresAtUtc': instance.expiresAtUtc,
  'currency': instance.currency,
  'subtotal': instance.subtotal,
  'discount': instance.discount,
  'fees': instance.fees,
  'total': instance.total,
  'deposit': instance.deposit,
  'remainingBalance': instance.remainingBalance,
  'subjectToConfirmation': instance.subjectToConfirmation,
  'confirmationNote': instance.confirmationNote,
  'policySummary': instance.policySummary,
  'netPitchPrice': instance.netPitchPrice,
  'platformCommission': instance.platformCommission,
  'onlineDepositAmount': instance.onlineDepositAmount,
  'venuePayAmount': instance.venuePayAmount,
};
