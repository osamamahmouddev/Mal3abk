import 'package:json_annotation/json_annotation.dart';

/// Server `BookingStatus`, sent as its number.
enum BookingStatus {
  @JsonValue(1)
  draft,
  @JsonValue(2)
  pendingDeposit,
  @JsonValue(3)
  proofSubmitted,
  @JsonValue(4)
  underReview,
  @JsonValue(5)
  confirmed,
  @JsonValue(6)
  rejected,
  @JsonValue(7)
  expired,
  @JsonValue(8)
  cancelled,
  @JsonValue(9)
  completed,
  @JsonValue(10)
  noShow;

  bool get isAwaitingVenue => this == proofSubmitted || this == underReview;

  bool get isClosed =>
      this == rejected ||
      this == expired ||
      this == cancelled ||
      this == completed ||
      this == noShow;

  /// A confirmed booking is the one that gets a pass with a QR code.
  bool get hasPass => this == confirmed || this == completed;
}
