import 'package:json_annotation/json_annotation.dart';

part 'booking_quote_request_body.g.dart';

@JsonSerializable()
class BookingQuoteRequestBody {
  const BookingQuoteRequestBody({
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
  });

  final String pitchId;
  final String startUtc;
  final String endUtc;

  factory BookingQuoteRequestBody.fromJson(Map<String, dynamic> json) =>
      _$BookingQuoteRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BookingQuoteRequestBodyToJson(this);
}
