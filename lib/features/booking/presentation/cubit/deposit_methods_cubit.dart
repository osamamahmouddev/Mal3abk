import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/booking_repo.dart';
import 'deposit_methods_state.dart';

class DepositMethodsCubit extends Cubit<DepositMethodsState>
    with SafeEmitCubitMixin<DepositMethodsState> {
  DepositMethodsCubit({required this.bookingRepo})
    : super(const DepositMethodsState.loading());

  final BookingRepo bookingRepo;

  Future<void> load(String bookingId) async {
    emitIfOpen(const DepositMethodsState.loading());
    final result = await bookingRepo.getPaymentMethods(bookingId);
    result.when(
      success: (methods) => emitIfOpen(DepositMethodsState.success(methods)),
      failure: (failure) =>
          emitIfOpen(DepositMethodsState.error(failure.message)),
    );
  }
}
