import 'package:json_annotation/json_annotation.dart';

part 'cancel_booking_request_body.g.dart';

@JsonSerializable(includeIfNull: false)
class CancelBookingRequestBody {
  const CancelBookingRequestBody({this.reason});

  final String? reason;

  factory CancelBookingRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CancelBookingRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CancelBookingRequestBodyToJson(this);
}
