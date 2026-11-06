import 'package:json_annotation/json_annotation.dart';

part 'create_booking_request_body.g.dart';

@JsonSerializable()
class CreateBookingRequestBody {
  const CreateBookingRequestBody({
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
    required this.quoteToken,
    required this.expectedPrice,
    this.customerName,
    this.customerPhone,
  });

  final String pitchId;
  final String startUtc;
  final String endUtc;
  final String quoteToken;
  final double expectedPrice;
  final String? customerName;
  final String? customerPhone;

  factory CreateBookingRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingRequestBodyToJson(this);
}
