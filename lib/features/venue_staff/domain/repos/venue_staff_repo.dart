import '../../../../core/network/api_result.dart';
import '../../data/models/venue_staff_model.dart';

abstract class VenueStaffRepo {
  Future<ApiResult<VenueStaffModel>> getStaff(String venueId);

  /// Invites by email when [contact] has an @, otherwise by mobile number.
  Future<ApiResult<void>> invite(String venueId, String contact, String role);

  Future<ApiResult<void>> resendInvitation(String venueId, String invitationId);

  Future<ApiResult<void>> cancelInvitation(String venueId, String invitationId);

  Future<ApiResult<void>> changeRole(
    String venueId,
    String memberId,
    String role,
  );

  Future<ApiResult<void>> removeMember(String venueId, String memberId);
}
