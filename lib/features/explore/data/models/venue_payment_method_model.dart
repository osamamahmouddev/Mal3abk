import 'package:json_annotation/json_annotation.dart';

part 'venue_payment_method_model.g.dart';

@JsonSerializable()
class VenuePaymentMethodModel {
  const VenuePaymentMethodModel({
    required this.id,
    required this.venueId,
    required this.methodType,
    required this.recipientName,
    required this.accountDetailsMasked,
    this.instructions,
    required this.depositType,
    required this.depositValue,
    this.isActive = true,
  });

  final String id;
  final String venueId;
  final String methodType;
  final String recipientName;
  final String accountDetailsMasked;
  final String? instructions;
  final String depositType;
  final double depositValue;
  final bool isActive;

  factory VenuePaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$VenuePaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$VenuePaymentMethodModelToJson(this);
}
