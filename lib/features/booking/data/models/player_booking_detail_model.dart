import 'package:json_annotation/json_annotation.dart';

import 'booking_status.dart';
import 'player_booking_summary_model.dart';

part 'player_booking_detail_model.g.dart';

@JsonSerializable()
class PlayerProofModel {
  const PlayerProofModel({
    required this.id,
    required this.originalFileName,
    required this.contentType,
    required this.fileSizeBytes,
    this.isApproved,
    this.rejectionReason,
    required this.uploadedAtUtc,
  });

  final String id;
  final String originalFileName;
  final String contentType;
  final int fileSizeBytes;
  final bool? isApproved;
  final String? rejectionReason;
  final String uploadedAtUtc;

  factory PlayerProofModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerProofModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerProofModelToJson(this);
}

@JsonSerializable()
class PlayerStatusHistoryModel {
  const PlayerStatusHistoryModel({
    required this.status,
    required this.changedBy,
    this.reason,
    required this.changedAtUtc,
  });

  @JsonKey(unknownEnumValue: BookingStatus.draft)
  final BookingStatus status;
  final String changedBy;
  final String? reason;
  final String changedAtUtc;

  factory PlayerStatusHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatusHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerStatusHistoryModelToJson(this);
}

@JsonSerializable()
class PlayerVenueModel {
  const PlayerVenueModel({
    required this.name,
    required this.address,
    this.latitude,
    this.longitude,
  });

  final String name;
  final String address;
  final double? latitude;
  final double? longitude;

  bool get hasLocation => latitude != null && longitude != null;

  factory PlayerVenueModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerVenueModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerVenueModelToJson(this);
}

@JsonSerializable()
class PlayerBookingDetailModel {
  const PlayerBookingDetailModel({
    required this.id,
    required this.reference,
    required this.venueId,
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
    required this.totalPrice,
    required this.depositAmount,
    required this.currency,
    required this.status,
    this.holdExpiresAtUtc,
    this.notes,
    this.cancellationPolicySummary,
    this.venue,
    this.pitchName,
    required this.allowedActions,
    this.proofs = const [],
    this.statusHistory = const [],
    required this.createdAtUtc,
  });

  final String id;
  final String reference;
  final String venueId;
  final String pitchId;
  final String startUtc;
  final String endUtc;
  final double totalPrice;
  final double depositAmount;
  final String currency;
  @JsonKey(unknownEnumValue: BookingStatus.draft)
  final BookingStatus status;
  final String? holdExpiresAtUtc;
  final String? notes;
  final String? cancellationPolicySummary;
  final PlayerAllowedActionsModel allowedActions;
  final List<PlayerProofModel> proofs;
  final List<PlayerStatusHistoryModel> statusHistory;
  final String createdAtUtc;

  final PlayerVenueModel? venue;
  final String? pitchName;

  DateTime get startAt => DateTime.parse(startUtc);
  DateTime get endAt => DateTime.parse(endUtc);

  factory PlayerBookingDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerBookingDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerBookingDetailModelToJson(this);
}
