// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_payment_method_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingPaymentMethodModel _$BookingPaymentMethodModelFromJson(
  Map<String, dynamic> json,
) => BookingPaymentMethodModel(
  id: json['id'] as String,
  methodType: json['methodType'] as String,
  recipientName: json['recipientName'] as String,
  accountDetails: json['accountDetails'] as String,
  instructions: json['instructions'] as String?,
);

Map<String, dynamic> _$BookingPaymentMethodModelToJson(
  BookingPaymentMethodModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'methodType': instance.methodType,
  'recipientName': instance.recipientName,
  'accountDetails': instance.accountDetails,
  'instructions': instance.instructions,
};
