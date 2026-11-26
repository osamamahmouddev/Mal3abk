import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/venue_staff_repo.dart';
import '../apis/venue_staff_api_service.dart';
import '../models/venue_staff_model.dart';

class VenueStaffRepoImpl implements VenueStaffRepo {
  VenueStaffRepoImpl({required this.apiService});

  final VenueStaffApiService apiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<VenueStaffModel>> getStaff(String venueId) =>
      _guard(() => apiService.getStaff(venueId));

  @override
  Future<ApiResult<void>> invite(String venueId, String contact, String role) {
    final value = contact.trim();
    final isEmail = value.contains('@');
    return _guard(
      () => apiService.invite(venueId, {
        'email': isEmail ? value : null,
        'phoneNumber': isEmail
            ? null
            : value.toLatinDigits().replaceAll(RegExp(r'\D'), ''),
        'role': StaffRoles.valueOf(role),
      }),
    );
  }

  @override
  Future<ApiResult<void>> resendInvitation(
    String venueId,
    String invitationId,
  ) => _guard(() => apiService.resendInvitation(venueId, invitationId));

  @override
  Future<ApiResult<void>> cancelInvitation(
    String venueId,
    String invitationId,
  ) => _guard(() => apiService.cancelInvitation(venueId, invitationId));

  @override
  Future<ApiResult<void>> changeRole(
    String venueId,
    String memberId,
    String role,
  ) => _guard(
    () => apiService.changeRole(venueId, memberId, {
      'role': StaffRoles.valueOf(role),
    }),
  );

  @override
  Future<ApiResult<void>> removeMember(String venueId, String memberId) =>
      _guard(() => apiService.removeMember(venueId, memberId));
}
