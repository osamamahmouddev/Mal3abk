import 'package:json_annotation/json_annotation.dart';

import 'booking_status.dart';

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
    this.pitchName,
    this.venueName,
    this.platformCommission = 0.0,
    this.venueNetAmount = 0.0,
    this.onlineDepositAmount = 0.0,
    this.venuePayAmount = 0.0,
  });

  final String bookingId;
  final String bookingReference;
  final String venueId;
  final String pitchId;
  final String? pitchName;
  final String? venueName;
  final String startUtc;
  final String endUtc;
  final double totalPrice;
  final double depositAmount;
  final String currency;
  @JsonKey(unknownEnumValue: BookingStatus.draft)
  final BookingStatus status;
  final String holdExpiresAtUtc;
  final String? paymentInstructions;
  final double platformCommission;
  final double venueNetAmount;
  final double onlineDepositAmount;
  final double venuePayAmount;

  CreateBookingResponseModel copyWith({
    String? pitchName,
    String? venueName,
  }) {
    return CreateBookingResponseModel(
      bookingId: bookingId,
      bookingReference: bookingReference,
      venueId: venueId,
      pitchId: pitchId,
      pitchName: pitchName ?? this.pitchName,
      venueName: venueName ?? this.venueName,
      startUtc: startUtc,
      endUtc: endUtc,
      totalPrice: totalPrice,
      depositAmount: depositAmount,
      currency: currency,
      status: status,
      holdExpiresAtUtc: holdExpiresAtUtc,
      paymentInstructions: paymentInstructions,
      platformCommission: platformCommission,
      venueNetAmount: venueNetAmount,
      onlineDepositAmount: onlineDepositAmount,
      venuePayAmount: venuePayAmount,
    );
  }

  factory CreateBookingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingResponseModelToJson(this);
}
