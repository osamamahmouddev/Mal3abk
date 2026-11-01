import 'package:json_annotation/json_annotation.dart';

part 'create_booking_response_model.g.dart';

@JsonSerializable()
class CreateBookingResponseModel {
  const CreateBookingResponseModel({
    required this.bookingId,
    required this.bookingReference,
    required this.venueId,
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
    required this.totalPrice,
    required this.depositAmount,
    required this.currency,
    required this.status,
    required this.holdExpiresAtUtc,
    this.paymentInstructions,
  });

  final String bookingId;
  final String bookingReference;
  final String venueId;
  final String pitchId;
  final String startUtc;
  final String endUtc;
  final double totalPrice;
  final double depositAmount;
  final String currency;
  final dynamic status;
  final String holdExpiresAtUtc;
  final String? paymentInstructions;

  factory CreateBookingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingResponseModelToJson(this);
}
