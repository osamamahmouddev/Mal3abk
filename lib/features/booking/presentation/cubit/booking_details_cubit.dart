import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/services/realtime_service.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_booking_detail_use_case.dart';
import 'booking_details_state.dart';

class BookingDetailsCubit extends Cubit<BookingDetailsState>
    with SafeEmitCubitMixin<BookingDetailsState> {
  BookingDetailsCubit({required this.getBookingDetailUseCase, this.realtime})
    : super(const BookingDetailsState.initial()) {
    // The venue approves or rejects while the player is looking: reload.
    _subscriptions = [
      ?realtime?.bookingUpdates
          .where((update) => update.bookingId == _bookingId)
          .listen((_) => _reload()),
      ?realtime?.reconnected.listen((_) => _reload()),
    ];
  }

  final GetBookingDetailUseCase getBookingDetailUseCase;

  /// Live booking changes; without it the screen reloads only on demand.
  final RealtimeService? realtime;

  late final List<StreamSubscription<Object?>> _subscriptions;
  String? _bookingId;

  Future<void> load(String bookingId) async {
    _bookingId = bookingId;
    unawaited(realtime?.connect());
    if (state is! BookingDetailsSuccess) {
      emitIfOpen(const BookingDetailsState.loading());
    }
    final result = await getBookingDetailUseCase(bookingId);
    result.when(
      success: (booking) => emitIfOpen(BookingDetailsState.success(booking)),
      failure: (failure) =>
          emitIfOpen(BookingDetailsState.error(failure.message)),
    );
  }

  void _reload() {
    final id = _bookingId;
    if (id != null) unawaited(load(id));
  }

  @override
  Future<void> close() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
