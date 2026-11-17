import 'package:json_annotation/json_annotation.dart';

part 'booking_quote_response_model.g.dart';

@JsonSerializable()
class BookingQuoteResponseModel {
  const BookingQuoteResponseModel({
    required this.quoteToken,
    required this.expiresAtUtc,
    required this.currency,
    required this.subtotal,
    required this.discount,
    required this.fees,
    required this.total,
    required this.deposit,
    required this.remainingBalance,
    required this.subjectToConfirmation,
    required this.confirmationNote,
    this.policySummary = const [],
    this.netPitchPrice = 0,
    this.platformCommission = 0,
    this.onlineDepositAmount = 0,
    this.venuePayAmount = 0,
  });

  final String quoteToken;
  final String expiresAtUtc;
  final String currency;
  final double subtotal;
  final double discount;
  final double fees;
  final double total;
  final double deposit;
  final double remainingBalance;
  final bool subjectToConfirmation;
  final String confirmationNote;
  final List<String> policySummary;

  /// Net venue rent after the server-applied discount.
  @JsonKey(defaultValue: 0)
  final double netPitchPrice;

  /// The platform commission calculated by the server.
  @JsonKey(defaultValue: 0)
  final double platformCommission;

  /// The amount the player must pay online to confirm the booking.
  @JsonKey(defaultValue: 0)
  final double onlineDepositAmount;

  /// The net amount the player pays at the venue on arrival.
  @JsonKey(defaultValue: 0)
  final double venuePayAmount;

  factory BookingQuoteResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BookingQuoteResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingQuoteResponseModelToJson(this);
}
