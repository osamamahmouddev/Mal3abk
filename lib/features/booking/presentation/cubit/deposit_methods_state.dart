import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/booking_payment_method_model.dart';

part 'deposit_methods_state.freezed.dart';

@freezed
sealed class DepositMethodsState with _$DepositMethodsState {
  const factory DepositMethodsState.loading() = DepositMethodsLoading;
  const factory DepositMethodsState.success(
    List<BookingPaymentMethodModel> methods,
  ) = DepositMethodsSuccess;
  const factory DepositMethodsState.error(String message) = DepositMethodsError;
}
