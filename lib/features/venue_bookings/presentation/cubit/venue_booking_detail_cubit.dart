import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/venue_bookings_repo.dart';
import 'venue_booking_detail_state.dart';

class VenueBookingDetailCubit extends Cubit<VenueBookingDetailState>
    with SafeEmitCubitMixin<VenueBookingDetailState> {
  VenueBookingDetailCubit({required this.venueBookingsRepo})
    : super(const VenueBookingDetailState.loading());

  final VenueBookingsRepo venueBookingsRepo;

  late String _venueId;
  late String _bookingId;

  /// True once any action changed the booking, so lists reload on return.
  bool changed = false;

  Future<void> load(String venueId, String bookingId) async {
    _venueId = venueId;
    _bookingId = bookingId;
    if (state is! VenueBookingDetailSuccess) {
      emitIfOpen(const VenueBookingDetailState.loading());
    }
    final result = await venueBookingsRepo.getBooking(venueId, bookingId);
    result.when(
      success: (booking) =>
          emitIfOpen(VenueBookingDetailState.success(booking: booking)),
      failure: (failure) =>
          emitIfOpen(VenueBookingDetailState.error(failure.message)),
    );
  }

  Future<void> confirmManual() => _run(
    VenueBookingAction.confirm,
    () => venueBookingsRepo.confirmManual(_venueId, _bookingId),
  );

  Future<void> cancel(String reason) => _run(
    VenueBookingAction.cancel,
    () => venueBookingsRepo.cancel(_venueId, _bookingId, reason),
  );

  Future<void> markNoShow(String reason) => _run(
    VenueBookingAction.noShow,
    () => venueBookingsRepo.markNoShow(_venueId, _bookingId, reason),
  );

  Future<void> _run(
    VenueBookingAction action,
    Future<ApiResult<void>> Function() call,
  ) async {
    final current = state;
    if (current is! VenueBookingDetailSuccess || current.busy != null) return;
    emitIfOpen(current.copyWith(busy: action, done: null, actionError: null));
    final result = await call();
    await result.when(
      success: (_) async {
        changed = true;
        final fresh = await venueBookingsRepo.getBooking(_venueId, _bookingId);
        emitIfOpen(
          VenueBookingDetailState.success(
            booking: fresh.when(
              success: (b) => b,
              failure: (_) => current.booking,
            ),
            done: action,
          ),
        );
      },
      failure: (failure) async => emitIfOpen(
        current.copyWith(busy: null, actionError: failure.message),
      ),
    );
  }
}
