import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/idempotency_keys.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/booking_repo.dart';
import 'cancel_booking_state.dart';

class CancelBookingCubit extends Cubit<CancelBookingState>
    with SafeEmitCubitMixin<CancelBookingState> {
  CancelBookingCubit({required this.bookingRepo})
    : super(const CancelBookingState.loading());

  final BookingRepo bookingRepo;
  final IdempotencyKeys _keys = IdempotencyKeys();

  Future<void> loadPreview(String bookingId) async {
    emitIfOpen(const CancelBookingState.loading());
    final result = await bookingRepo.getCancelPreview(bookingId);
    result.when(
      success: (preview) => emitIfOpen(CancelBookingState.ready(preview)),
      failure: (failure) =>
          emitIfOpen(CancelBookingState.error(failure.message)),
    );
  }

  Future<void> cancel(String bookingId, {String? reason}) async {
    final current = state;
    if (current is! CancelBookingReady ||
        current.submitting ||
        !current.preview.canCancel) {
      return;
    }
    emitIfOpen(current.copyWith(submitting: true, failure: null));
    final operation = 'cancel:$bookingId';
    final result = await bookingRepo.cancelBooking(
      bookingId,
      idempotencyKey: _keys.keyFor(operation),
      reason: reason,
    );
    result.when(
      success: (_) {
        _keys.complete(operation);
        emitIfOpen(const CancelBookingState.cancelled());
      },
      failure: (failure) => emitIfOpen(
        current.copyWith(submitting: false, failure: failure.message),
      ),
    );
  }
}
