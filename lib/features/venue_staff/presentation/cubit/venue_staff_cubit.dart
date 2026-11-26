import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/venue_staff_model.dart';
import '../../domain/repos/venue_staff_repo.dart';

part 'venue_staff_cubit.freezed.dart';

@freezed
abstract class VenueStaffState with _$VenueStaffState {
  const factory VenueStaffState({
    @Default(VenueStaffModel()) VenueStaffModel staff,
    @Default(true) bool loading,
    @Default(false) bool busy,
    String? error,
  }) = _VenueStaffState;
}

/// The venue's team: invite by email or mobile, change roles, remove, and
/// resend or cancel pending invitations.
class VenueStaffCubit extends Cubit<VenueStaffState>
    with SafeEmitCubitMixin<VenueStaffState> {
  VenueStaffCubit({required this.venueStaffRepo, required this.venueId})
    : super(const VenueStaffState());

  final VenueStaffRepo venueStaffRepo;
  final String venueId;

  Future<void> load() async {
    final result = await venueStaffRepo.getStaff(venueId);
    result.when(
      success: (s) =>
          emitIfOpen(state.copyWith(staff: s, loading: false, error: null)),
      failure: (f) =>
          emitIfOpen(state.copyWith(loading: false, error: f.message)),
    );
  }

  Future<String?> invite(String contact, String role) {
    final value = contact.trim();
    if (value.isEmpty) return Future.value('venue.staff.contact_required');
    return _run(() => venueStaffRepo.invite(venueId, value, role));
  }

  Future<String?> resend(String invitationId) =>
      _run(() => venueStaffRepo.resendInvitation(venueId, invitationId));

  Future<String?> cancelInvitation(String invitationId) =>
      _run(() => venueStaffRepo.cancelInvitation(venueId, invitationId));

  Future<String?> changeRole(String memberId, String role) =>
      _run(() => venueStaffRepo.changeRole(venueId, memberId, role));

  Future<String?> remove(String memberId) =>
      _run(() => venueStaffRepo.removeMember(venueId, memberId));

  /// Returns the failure key, or null once done (the list then reloads).
  Future<String?> _run(Future<ApiResult<void>> Function() call) async {
    emitIfOpen(state.copyWith(busy: true));
    final result = await call();
    emitIfOpen(state.copyWith(busy: false));
    return result.when(
      success: (_) {
        load();
        return null;
      },
      failure: (f) => f.message,
    );
  }
}
