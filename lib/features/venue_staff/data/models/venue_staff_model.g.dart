// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_staff_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueStaffModel _$VenueStaffModelFromJson(Map<String, dynamic> json) =>
    VenueStaffModel(
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => StaffMemberModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pendingInvitations:
          (json['pendingInvitations'] as List<dynamic>?)
              ?.map(
                (e) => StaffInvitationModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

StaffMemberModel _$StaffMemberModelFromJson(Map<String, dynamic> json) =>
    StaffMemberModel(
      memberId: json['memberId'] as String,
      role: json['role'] as String,
      addedAtUtc: json['addedAtUtc'] as String,
      fullName: json['fullName'] as String?,
    );

StaffInvitationModel _$StaffInvitationModelFromJson(
  Map<String, dynamic> json,
) => StaffInvitationModel(
  invitationId: json['invitationId'] as String,
  role: json['role'] as String,
  expiresAtUtc: json['expiresAtUtc'] as String,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  status: json['status'] as String? ?? '',
);
