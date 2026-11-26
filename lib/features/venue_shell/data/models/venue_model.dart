import 'package:json_annotation/json_annotation.dart';

import 'venue_pitch_model.dart';

part 'venue_model.g.dart';

/// A venue the signed-in owner or staff member manages (`VenueDto`).
@JsonSerializable(createToJson: false)
class VenueModel {
  const VenueModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.area,
    required this.phoneNumber,
    required this.approvalStatus,
    required this.isApproved,
    required this.isPublished,
    this.description,
    this.latitude,
    this.longitude,
    this.facilities = const [],
    this.photos = const [],
    this.pitches = const [],
    this.pricingModel = 'Commission',
    this.commissionType,
    this.commissionRate,
  });

  final String id;
  final String name;
  final String? description;
  final String address;
  final String city;
  final String area;
  final double? latitude;
  final double? longitude;
  final String phoneNumber;

  /// `Draft`, `Submitted`, `NeedsInfo`, `Approved`, `Rejected`, `Suspended`.
  final String approvalStatus;
  final bool isApproved;
  final bool isPublished;
  final List<String> facilities;
  final List<String> photos;
  final List<VenuePitchModel> pitches;
  final String pricingModel;
  final String? commissionType;
  final double? commissionRate;

  List<VenuePitchModel> get activePitches =>
      pitches.where((p) => p.isActive).toList();

  factory VenueModel.fromJson(Map<String, dynamic> json) =>
      _$VenueModelFromJson(json);
}
