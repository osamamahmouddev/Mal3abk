import 'package:json_annotation/json_annotation.dart';

part 'venue_staff_model.g.dart';

/// The venue's team and pending invitations (`VenueStaffDto`).
@JsonSerializable(createToJson: false)
class VenueStaffModel {
  const VenueStaffModel({
    this.members = const [],
    this.pendingInvitations = const [],
  });

  final List<StaffMemberModel> members;
  final List<StaffInvitationModel> pendingInvitations;

  factory VenueStaffModel.fromJson(Map<String, dynamic> json) =>
      _$VenueStaffModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class StaffMemberModel {
  const StaffMemberModel({
    required this.memberId,
    required this.role,
    required this.addedAtUtc,
    this.fullName,
  });

  final String memberId;

  /// `Manager`, `Receptionist`, `Accountant`.
  final String role;
  final String addedAtUtc;
  final String? fullName;

  factory StaffMemberModel.fromJson(Map<String, dynamic> json) =>
      _$StaffMemberModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class StaffInvitationModel {
  const StaffInvitationModel({
    required this.invitationId,
    required this.role,
    required this.expiresAtUtc,
    this.email,
    this.phoneNumber,
    this.status = '',
  });

  final String invitationId;
  final String? email;
  final String? phoneNumber;
  final String role;
  final String status;
  final String expiresAtUtc;

  factory StaffInvitationModel.fromJson(Map<String, dynamic> json) =>
      _$StaffInvitationModelFromJson(json);
}

/// `VenueStaffRole` on the API, in its order.
abstract final class StaffRoles {
  static const List<String> all = ['Manager', 'Receptionist', 'Accountant'];

  static int valueOf(String role) => all.indexOf(role);

  /// What each role may do, as the web page lists it: (owner, manager,
  /// receptionist, accountant).
  static const List<(String, List<bool>)> matrix = [
    ('proofs', [true, true, true, false]),
    ('manual', [true, true, true, false]),
    ('cancel', [true, true, false, false]),
    ('pitches', [true, true, false, false]),
    ('finance', [true, true, false, true]),
    ('staff', [true, false, false, false]),
  ];
}
