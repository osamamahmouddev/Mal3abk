import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/pay_booking_commission_use_case.dart';
import 'pay_commission_state.dart';

class PayCommissionCubit extends Cubit<PayCommissionState>
    with SafeEmitCubitMixin<PayCommissionState> {
  PayCommissionCubit({required this.payBookingCommissionUseCase})
    : super(const PayCommissionState.initial());

  final PayBookingCommissionUseCase payBookingCommissionUseCase;

  Future<void> pay(String bookingId) async {
    if (state is PayCommissionLoading) return;
    emitIfOpen(const PayCommissionState.loading());
    final result = await payBookingCommissionUseCase(bookingId);
    result.when(
      success: (data) =>
          emitIfOpen(PayCommissionState.success(data.checkoutUrl)),
      failure: (failure) =>
          emitIfOpen(PayCommissionState.error(failure.message)),
    );
  }

  /// The checkout page could not be opened on this device.
  void launchFailed(String messageKey) =>
      emitIfOpen(PayCommissionState.error(messageKey));
}
