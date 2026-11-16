import 'package:json_annotation/json_annotation.dart';

part 'paymob_checkout_response_model.g.dart';

@JsonSerializable()
class PaymobCheckoutResponseModel {
  const PaymobCheckoutResponseModel({
    required this.clientSecret,
    required this.checkoutUrl,
    required this.amount,
    required this.currency,
    required this.requiresRedirect,
  });

  final String clientSecret;
  final String checkoutUrl;
  final double amount;
  final String currency;
  final bool requiresRedirect;

  factory PaymobCheckoutResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaymobCheckoutResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymobCheckoutResponseModelToJson(this);
}
