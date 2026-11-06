import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_booking_detail_use_case.dart';
import 'booking_details_state.dart';

class BookingDetailsCubit extends Cubit<BookingDetailsState>
    with SafeEmitCubitMixin<BookingDetailsState> {
  BookingDetailsCubit({required this.getBookingDetailUseCase})
    : super(const BookingDetailsState.initial());

  final GetBookingDetailUseCase getBookingDetailUseCase;

  Future<void> load(String bookingId) async {
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
}
