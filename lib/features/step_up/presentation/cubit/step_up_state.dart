import 'package:freezed_annotation/freezed_annotation.dart';

part 'step_up_state.freezed.dart';

@freezed
sealed class StepUpState with _$StepUpState {
  const factory StepUpState.sending() = StepUpSending;
  const factory StepUpState.codeSent() = StepUpCodeSent;
  const factory StepUpState.verifying() = StepUpVerifying;
  const factory StepUpState.verified(String token) = StepUpVerified;
  const factory StepUpState.error(String message, {required bool codeSent}) =
      StepUpError;
}
