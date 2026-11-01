import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_my_bookings_use_case.dart';
import 'my_bookings_state.dart';

class MyBookingsCubit extends Cubit<MyBookingsState>
    with SafeEmitCubitMixin<MyBookingsState> {
  MyBookingsCubit({required this.getMyBookingsUseCase})
    : super(const MyBookingsState.initial());

  final GetMyBookingsUseCase getMyBookingsUseCase;

  Future<void> fetchBookings({String? tab, int? page, int? pageSize}) async {
    emitIfOpen(const MyBookingsState.loading());
    final result = await getMyBookingsUseCase(
      tab: tab,
      page: page,
      pageSize: pageSize,
    );
    result.when(
      success: (data) => emitIfOpen(MyBookingsState.success(data)),
      failure: (failure) => emitIfOpen(MyBookingsState.error(failure.message)),
    );
  }
}
