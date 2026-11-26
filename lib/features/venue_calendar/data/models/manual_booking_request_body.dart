import 'package:json_annotation/json_annotation.dart';

part 'manual_booking_request_body.g.dart';

/// What the customer has paid so far; the numbers are the API's
/// `ManualPaymentStatus`.
enum ManualPaymentStatus {
  full(0),
  deposit(1),
  awaiting(2),
  unconfirmed(3);

  const ManualPaymentStatus(this.value);
  final int value;
}

/// A phone or walk-in booking (`CreateManualBookingApiRequest`).
@JsonSerializable(createFactory: false, includeIfNull: false)
class ManualBookingRequestBody {
  const ManualBookingRequestBody({
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
    required this.price,
    required this.paymentStatus,
    this.currency = 'EGP',
    this.customerName,
    this.customerPhone,
    this.notes,
    this.depositAmount,
  });

  final String pitchId;
  final String startUtc;
  final String endUtc;
  final double price;
  final String currency;
  final String? customerName;
  final String? customerPhone;
  final String? notes;
  final int paymentStatus;
  final double? depositAmount;

  Map<String, dynamic> toJson() => _$ManualBookingRequestBodyToJson(this);
}

/// One hour picked in the calendar to book or block.
class CalendarHour {
  const CalendarHour({
    required this.pitchId,
    required this.start,
    required this.end,
  });

  final String pitchId;
  final DateTime start;
  final DateTime end;

  String get key => '$pitchId|${start.toIso8601String()}';

  Map<String, dynamic> toJson() => {
    'pitchId': pitchId,
    'startUtc': start.toUtc().toIso8601String(),
    'endUtc': end.toUtc().toIso8601String(),
  };
}

/// What a bulk booking or release did, slot by slot.
class BulkOutcome {
  const BulkOutcome({
    required this.succeeded,
    required this.failed,
    this.firstErrorCode,
    this.firstError,
  });

  final int succeeded;
  final int failed;
  final String? firstErrorCode;
  final String? firstError;

  factory BulkOutcome.fromBookJson(Map<String, dynamic> json) {
    final failed = [
      for (final s in (json['slots'] as List? ?? const []))
        if (s is Map && s['succeeded'] != true) s,
    ];
    return BulkOutcome(
      succeeded: (json['succeeded'] as num?)?.toInt() ?? 0,
      failed: failed.length,
      firstErrorCode: failed.firstOrNull?['errorCode'] as String?,
      firstError: failed.firstOrNull?['error'] as String?,
    );
  }

  factory BulkOutcome.fromReleaseJson(Map<String, dynamic> json) => BulkOutcome(
    succeeded: (json['succeeded'] as num?)?.toInt() ?? 0,
    failed: (json['failed'] as num?)?.toInt() ?? 0,
  );
}
