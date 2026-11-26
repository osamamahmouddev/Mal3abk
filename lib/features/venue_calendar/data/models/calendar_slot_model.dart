import 'package:json_annotation/json_annotation.dart';

part 'calendar_slot_model.g.dart';

/// How a taken slot shows in the calendar, as the venue web colours it.
enum CalendarSlotKind { confirmed, tentative, review, waiting, blocked }

/// A booking or blocked period in the venue calendar (`CalendarSlotDto`).
@JsonSerializable(createToJson: false)
class CalendarSlotModel {
  const CalendarSlotModel({
    required this.id,
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
    required this.status,
    this.customerName,
    this.bookingReference = '',
    this.isManual = false,
    this.reason,
    this.customerPhone,
    this.depositAmount = 0,
    this.isTentative = false,
  });

  /// The booking id, or the blocked slot id when [status] is `Blocked`.
  final String id;
  final String pitchId;
  final String startUtc;
  final String endUtc;

  /// `Blocked`, `PendingDeposit`, `ProofSubmitted`, `UnderReview`,
  /// `Confirmed`, ...
  final String status;
  final String? customerName;
  final String bookingReference;
  final bool isManual;
  final String? reason;
  final String? customerPhone;
  final double depositAmount;
  final bool isTentative;

  bool get isBlocked => status == 'Blocked';

  DateTime get start => DateTime.parse(startUtc).toUtc();
  DateTime get end => DateTime.parse(endUtc).toUtc();

  CalendarSlotKind get kind {
    if (isBlocked) return CalendarSlotKind.blocked;
    if (isTentative) return CalendarSlotKind.tentative;
    return switch (status) {
      'PendingDeposit' => CalendarSlotKind.waiting,
      'ProofSubmitted' || 'UnderReview' => CalendarSlotKind.review,
      _ => CalendarSlotKind.confirmed,
    };
  }

  /// A manual booking the venue can still confirm or free itself.
  bool get isOpenManual =>
      isManual && (status == 'PendingDeposit' || status == 'Confirmed');

  bool overlaps(DateTime from, DateTime to) =>
      start.isBefore(to) && end.isAfter(from);

  factory CalendarSlotModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarSlotModelFromJson(json);
}
