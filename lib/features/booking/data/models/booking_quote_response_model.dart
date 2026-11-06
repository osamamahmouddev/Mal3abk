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

  factory BookingQuoteResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BookingQuoteResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingQuoteResponseModelToJson(this);
}
