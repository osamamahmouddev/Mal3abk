// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymob_checkout_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymobCheckoutResponseModel _$PaymobCheckoutResponseModelFromJson(
        Map<String, dynamic> json) =>
    PaymobCheckoutResponseModel(
      clientSecret: json['clientSecret'] as String,
      checkoutUrl: json['checkoutUrl'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      requiresRedirect: json['requiresRedirect'] as bool,
    );

Map<String, dynamic> _$PaymobCheckoutResponseModelToJson(
        PaymobCheckoutResponseModel instance) =>
    <String, dynamic>{
      'clientSecret': instance.clientSecret,
      'checkoutUrl': instance.checkoutUrl,
      'amount': instance.amount,
      'currency': instance.currency,
      'requiresRedirect': instance.requiresRedirect,
    };
