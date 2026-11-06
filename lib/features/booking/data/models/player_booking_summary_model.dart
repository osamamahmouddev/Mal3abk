import 'package:json_annotation/json_annotation.dart';

import 'booking_status.dart';

part 'player_booking_summary_model.g.dart';

@JsonSerializable()
class PlayerAllowedActionsModel {
  const PlayerAllowedActionsModel({
    this.canUploadProof = false,
    this.canCancel = false,
    this.canReview = false,
    this.cancellationDeadlineUtc,
  });

  final bool canUploadProof;
  final bool canCancel;
  final bool canReview;
  final String? cancellationDeadlineUtc;

  factory PlayerAllowedActionsModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerAllowedActionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerAllowedActionsModelToJson(this);
}

@JsonSerializable()
class PlayerBookingSummaryModel {
  const PlayerBookingSummaryModel({
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
    required this.allowedActions,
    required this.createdAtUtc,
    this.venueName,
    this.pitchName,
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
  final PlayerAllowedActionsModel allowedActions;
  final String createdAtUtc;

  final String? venueName;
  final String? pitchName;

  DateTime get startAt => DateTime.parse(startUtc);
  DateTime get endAt => DateTime.parse(endUtc);

  factory PlayerBookingSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerBookingSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerBookingSummaryModelToJson(this);
}

@JsonSerializable()
class PlayerBookingsPagedListModel {
  const PlayerBookingsPagedListModel({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  final List<PlayerBookingSummaryModel> items;
  final int totalCount;
  final int page;
  final int pageSize;

  factory PlayerBookingsPagedListModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerBookingsPagedListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerBookingsPagedListModelToJson(this);
}
