import 'package:freezed_annotation/freezed_annotation.dart';

part 'pay_commission_state.freezed.dart';

@freezed
sealed class PayCommissionState with _$PayCommissionState {
  const factory PayCommissionState.initial() = PayCommissionInitial;
  const factory PayCommissionState.loading() = PayCommissionLoading;

  /// [checkoutUrl] is an HTTPS Paymob page, checked by the use case.
  const factory PayCommissionState.success(String checkoutUrl) =
      PayCommissionSuccess;
  const factory PayCommissionState.error(String message) = PayCommissionError;
}
