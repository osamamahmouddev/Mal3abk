import 'package:json_annotation/json_annotation.dart';

part 'venue_approval_model.g.dart';

/// The venue's review by the platform (`VenueApprovalDto`).
@JsonSerializable(createToJson: false)
class VenueApprovalModel {
  const VenueApprovalModel({
    required this.venueId,
    required this.approvalStatus,
    this.isPublished = false,
    this.isSearchable = false,
    this.history = const [],
  });

  final String venueId;
  final String approvalStatus;
  final bool isPublished;
  final bool isSearchable;
  final List<VenueApprovalEventModel> history;

  /// The last note the platform left when it asked for changes or rejected.
  String? get latestAdminMessage => history
      .where(
        (e) =>
            (e.message?.isNotEmpty ?? false) &&
            (e.action == 'InfoRequested' || e.action == 'Rejected'),
      )
      .lastOrNull
      ?.message;

  factory VenueApprovalModel.fromJson(Map<String, dynamic> json) =>
      _$VenueApprovalModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VenueApprovalEventModel {
  const VenueApprovalEventModel({
    required this.action,
    required this.createdAtUtc,
    this.fromStatus = '',
    this.toStatus = '',
    this.message,
  });

  final String action;
  final String fromStatus;
  final String toStatus;
  final String? message;
  final String createdAtUtc;

  factory VenueApprovalEventModel.fromJson(Map<String, dynamic> json) =>
      _$VenueApprovalEventModelFromJson(json);
}
