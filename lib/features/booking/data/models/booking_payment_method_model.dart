import 'package:json_annotation/json_annotation.dart';

part 'booking_payment_method_model.g.dart';

@JsonSerializable()
class BookingPaymentMethodModel {
  const BookingPaymentMethodModel({
    required this.id,
    required this.methodType,
    required this.recipientName,
    required this.accountDetails,
    this.instructions,
  });

  final String id;
  final String methodType;
  final String recipientName;
  final String accountDetails;
  final String? instructions;

  bool get isInstaPay => methodType == 'InstaPay';

  factory BookingPaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$BookingPaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingPaymentMethodModelToJson(this);
}
