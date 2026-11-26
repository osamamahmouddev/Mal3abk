import 'package:json_annotation/json_annotation.dart';

part 'venue_booking_detail_model.g.dart';

/// One booking with money split and history (`VenueBookingDetailDto`).
@JsonSerializable(createToJson: false)
class VenueBookingDetailModel {
  const VenueBookingDetailModel({
    required this.id,
    required this.reference,
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
    required this.status,
    this.totalPrice = 0,
    this.depositAmount = 0,
    this.currency = 'EGP',
    this.holdExpiresAtUtc,
    this.customerName,
    this.customerPhone,
    this.notes,
    this.statusHistory = const [],
    this.pitchName,
    this.platformCommission = 0,
    this.venueNetAmount = 0,
    this.venuePayAmount = 0,
    this.isCommissionPaid = false,
    this.isManual = false,
  });

  final String id;
  final String reference;
  final String pitchId;
  final String startUtc;
  final String endUtc;
  final double totalPrice;
  final double depositAmount;
  final String currency;
  final int status;
  final String? holdExpiresAtUtc;
  final String? customerName;
  final String? customerPhone;
  final String? notes;
  final List<VenueStatusHistoryModel> statusHistory;
  final String? pitchName;
  final double platformCommission;
  final double venueNetAmount;
  final double venuePayAmount;
  final bool isCommissionPaid;
  final bool isManual;

  factory VenueBookingDetailModel.fromJson(Map<String, dynamic> json) =>
      _$VenueBookingDetailModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VenueStatusHistoryModel {
  const VenueStatusHistoryModel({
    required this.status,
    required this.changedAtUtc,
    this.reason,
  });

  final int status;
  final String? reason;
  final String changedAtUtc;

  factory VenueStatusHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$VenueStatusHistoryModelFromJson(json);
}
