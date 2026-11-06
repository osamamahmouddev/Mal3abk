// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_booking_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerAllowedActionsModel _$PlayerAllowedActionsModelFromJson(
  Map<String, dynamic> json,
) => PlayerAllowedActionsModel(
  canUploadProof: json['canUploadProof'] as bool? ?? false,
  canCancel: json['canCancel'] as bool? ?? false,
  canReview: json['canReview'] as bool? ?? false,
  cancellationDeadlineUtc: json['cancellationDeadlineUtc'] as String?,
);

Map<String, dynamic> _$PlayerAllowedActionsModelToJson(
  PlayerAllowedActionsModel instance,
) => <String, dynamic>{
  'canUploadProof': instance.canUploadProof,
  'canCancel': instance.canCancel,
  'canReview': instance.canReview,
  'cancellationDeadlineUtc': instance.cancellationDeadlineUtc,
};

PlayerBookingSummaryModel _$PlayerBookingSummaryModelFromJson(
  Map<String, dynamic> json,
) => PlayerBookingSummaryModel(
  id: json['id'] as String,
  reference: json['reference'] as String,
  venueId: json['venueId'] as String,
  pitchId: json['pitchId'] as String,
  startUtc: json['startUtc'] as String,
  endUtc: json['endUtc'] as String,
  totalPrice: (json['totalPrice'] as num).toDouble(),
  depositAmount: (json['depositAmount'] as num).toDouble(),
  currency: json['currency'] as String,
  status: $enumDecode(
    _$BookingStatusEnumMap,
    json['status'],
    unknownValue: BookingStatus.draft,
  ),
  holdExpiresAtUtc: json['holdExpiresAtUtc'] as String?,
  allowedActions: PlayerAllowedActionsModel.fromJson(
    json['allowedActions'] as Map<String, dynamic>,
  ),
  createdAtUtc: json['createdAtUtc'] as String,
  venueName: json['venueName'] as String?,
  pitchName: json['pitchName'] as String?,
);

Map<String, dynamic> _$PlayerBookingSummaryModelToJson(
  PlayerBookingSummaryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'reference': instance.reference,
  'venueId': instance.venueId,
  'pitchId': instance.pitchId,
  'startUtc': instance.startUtc,
  'endUtc': instance.endUtc,
  'totalPrice': instance.totalPrice,
  'depositAmount': instance.depositAmount,
  'currency': instance.currency,
  'status': _$BookingStatusEnumMap[instance.status]!,
  'holdExpiresAtUtc': instance.holdExpiresAtUtc,
  'allowedActions': instance.allowedActions,
  'createdAtUtc': instance.createdAtUtc,
  'venueName': instance.venueName,
  'pitchName': instance.pitchName,
};

const _$BookingStatusEnumMap = {
  BookingStatus.draft: 1,
  BookingStatus.pendingDeposit: 2,
  BookingStatus.proofSubmitted: 3,
  BookingStatus.underReview: 4,
  BookingStatus.confirmed: 5,
  BookingStatus.rejected: 6,
  BookingStatus.expired: 7,
  BookingStatus.cancelled: 8,
  BookingStatus.completed: 9,
  BookingStatus.noShow: 10,
};

PlayerBookingsPagedListModel _$PlayerBookingsPagedListModelFromJson(
  Map<String, dynamic> json,
) => PlayerBookingsPagedListModel(
  items: (json['items'] as List<dynamic>)
      .map((e) => PlayerBookingSummaryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$PlayerBookingsPagedListModelToJson(
  PlayerBookingsPagedListModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
