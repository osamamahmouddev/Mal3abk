// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_approval_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueApprovalModel _$VenueApprovalModelFromJson(Map<String, dynamic> json) =>
    VenueApprovalModel(
      venueId: json['venueId'] as String,
      approvalStatus: json['approvalStatus'] as String,
      isPublished: json['isPublished'] as bool? ?? false,
      isSearchable: json['isSearchable'] as bool? ?? false,
      history:
          (json['history'] as List<dynamic>?)
              ?.map(
                (e) =>
                    VenueApprovalEventModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

VenueApprovalEventModel _$VenueApprovalEventModelFromJson(
  Map<String, dynamic> json,
) => VenueApprovalEventModel(
  action: json['action'] as String,
  createdAtUtc: json['createdAtUtc'] as String,
  fromStatus: json['fromStatus'] as String? ?? '',
  toStatus: json['toStatus'] as String? ?? '',
  message: json['message'] as String?,
);
