// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_booking_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerProofModel _$PlayerProofModelFromJson(Map<String, dynamic> json) =>
    PlayerProofModel(
      id: json['id'] as String,
      originalFileName: json['originalFileName'] as String,
      contentType: json['contentType'] as String,
      fileSizeBytes: (json['fileSizeBytes'] as num).toInt(),
      isApproved: json['isApproved'] as bool?,
      rejectionReason: json['rejectionReason'] as String?,
      uploadedAtUtc: json['uploadedAtUtc'] as String,
    );

Map<String, dynamic> _$PlayerProofModelToJson(PlayerProofModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originalFileName': instance.originalFileName,
      'contentType': instance.contentType,
      'fileSizeBytes': instance.fileSizeBytes,
      'isApproved': instance.isApproved,
      'rejectionReason': instance.rejectionReason,
      'uploadedAtUtc': instance.uploadedAtUtc,
    };

PlayerStatusHistoryModel _$PlayerStatusHistoryModelFromJson(
  Map<String, dynamic> json,
) => PlayerStatusHistoryModel(
  status: $enumDecode(
    _$BookingStatusEnumMap,
    json['status'],
    unknownValue: BookingStatus.draft,
  ),
  changedBy: json['changedBy'] as String,
  reason: json['reason'] as String?,
  changedAtUtc: json['changedAtUtc'] as String,
);

Map<String, dynamic> _$PlayerStatusHistoryModelToJson(
  PlayerStatusHistoryModel instance,
) => <String, dynamic>{
  'status': _$BookingStatusEnumMap[instance.status]!,
  'changedBy': instance.changedBy,
  'reason': instance.reason,
  'changedAtUtc': instance.changedAtUtc,
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

PlayerVenueModel _$PlayerVenueModelFromJson(Map<String, dynamic> json) =>
    PlayerVenueModel(
      name: json['name'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PlayerVenueModelToJson(PlayerVenueModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

PlayerBookingDetailModel _$PlayerBookingDetailModelFromJson(
  Map<String, dynamic> json,
) => PlayerBookingDetailModel(
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
  notes: json['notes'] as String?,
  cancellationPolicySummary: json['cancellationPolicySummary'] as String?,
  venue: json['venue'] == null
      ? null
      : PlayerVenueModel.fromJson(json['venue'] as Map<String, dynamic>),
  pitchName: json['pitchName'] as String?,
  allowedActions: PlayerAllowedActionsModel.fromJson(
    json['allowedActions'] as Map<String, dynamic>,
  ),
  proofs:
      (json['proofs'] as List<dynamic>?)
          ?.map((e) => PlayerProofModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  statusHistory:
      (json['statusHistory'] as List<dynamic>?)
          ?.map(
            (e) => PlayerStatusHistoryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  createdAtUtc: json['createdAtUtc'] as String,
);

Map<String, dynamic> _$PlayerBookingDetailModelToJson(
  PlayerBookingDetailModel instance,
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
  'notes': instance.notes,
  'cancellationPolicySummary': instance.cancellationPolicySummary,
  'allowedActions': instance.allowedActions,
  'proofs': instance.proofs,
  'statusHistory': instance.statusHistory,
  'createdAtUtc': instance.createdAtUtc,
  'venue': instance.venue,
  'pitchName': instance.pitchName,
};
