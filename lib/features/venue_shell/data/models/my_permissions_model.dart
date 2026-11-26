import 'package:json_annotation/json_annotation.dart';

part 'my_permissions_model.g.dart';

/// What the signed-in account may do, per venue (`MyPermissionsResponse`).
/// Only hides actions the role can't take: the API checks every request.
@JsonSerializable(createToJson: false)
class MyPermissionsModel {
  const MyPermissionsModel({
    this.roles = const [],
    this.permissions = const [],
    this.venues = const [],
  });

  final List<String> roles;
  final List<String> permissions;
  final List<VenuePermissionsModel> venues;

  Set<String> forVenue(String? venueId) => {
    ...?venues.where((v) => v.venueId == venueId).firstOrNull?.permissions,
  };

  factory MyPermissionsModel.fromJson(Map<String, dynamic> json) =>
      _$MyPermissionsModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VenuePermissionsModel {
  const VenuePermissionsModel({
    required this.venueId,
    this.accessLevel = '',
    this.permissions = const [],
  });

  final String venueId;
  final String accessLevel;
  final List<String> permissions;

  factory VenuePermissionsModel.fromJson(Map<String, dynamic> json) =>
      _$VenuePermissionsModelFromJson(json);
}

/// Venue-scoped permission names, as the API grants them per role.
abstract final class VenuePermissions {
  static const String venueView = 'venue.view';
  static const String venueEdit = 'venue.edit';
  static const String venuePublish = 'venue.publish';
  static const String pitchesManage = 'venue.pitches.manage';
  static const String schedulesManage = 'venue.schedules.manage';
  static const String blockedSlotsManage = 'venue.blocked_slots.manage';
  static const String policiesManage = 'venue.policies.manage';
  static const String paymentMethodsManage = 'venue.payment_methods.manage';
  static const String bookingsView = 'venue.bookings.view';
  static const String bookingsApprove = 'venue.bookings.approve';
  static const String proofsReview = 'venue.payment_proofs.review';
  static const String customersView = 'venue.customers.view';
  static const String reportsView = 'venue.reports.view';
  static const String staffManage = 'venue.staff.manage';
}
