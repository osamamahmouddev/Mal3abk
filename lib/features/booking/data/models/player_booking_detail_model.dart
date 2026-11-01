import 'package:json_annotation/json_annotation.dart';

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

  final dynamic status;
  final String changedBy;
  final String? reason;
  final String changedAtUtc;

  factory PlayerStatusHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatusHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerStatusHistoryModelToJson(this);
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
  final dynamic status;
  final String? holdExpiresAtUtc;
  final String? notes;
  final String? cancellationPolicySummary;
  final PlayerAllowedActionsModel allowedActions;
  final List<PlayerProofModel> proofs;
  final List<PlayerStatusHistoryModel> statusHistory;
  final String createdAtUtc;

  factory PlayerBookingDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerBookingDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerBookingDetailModelToJson(this);
}
