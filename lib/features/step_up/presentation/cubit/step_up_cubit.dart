import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/step_up_repo.dart';
import 'step_up_state.dart';

class StepUpCubit extends Cubit<StepUpState>
    with SafeEmitCubitMixin<StepUpState> {
  StepUpCubit({required this.stepUpRepo}) : super(const StepUpState.sending());

  static final RegExp _code = RegExp(r'^\d{6}$');

  final StepUpRepo stepUpRepo;
  bool _codeSent = false;

  Future<void> sendCode() async {
    emitIfOpen(const StepUpState.sending());
    final result = await stepUpRepo.sendCode();
    result.when(
      success: (_) {
        _codeSent = true;
        emitIfOpen(const StepUpState.codeSent());
      },
      failure: (failure) =>
          emitIfOpen(StepUpState.error(failure.message, codeSent: _codeSent)),
    );
  }

  Future<void> verify({required String scope, required String code}) async {
    if (state is StepUpVerifying || state is StepUpVerified) return;
    final trimmed = code.trim();
    if (!_code.hasMatch(trimmed)) {
      emitIfOpen(
        StepUpState.error('errors.identity.invalid_otp', codeSent: _codeSent),
      );
      return;
    }
    emitIfOpen(const StepUpState.verifying());
    final result = await stepUpRepo.verify(scope: scope, code: trimmed);
    result.when(
      success: (token) => emitIfOpen(StepUpState.verified(token)),
      failure: (failure) =>
          emitIfOpen(StepUpState.error(failure.message, codeSent: _codeSent)),
    );
  }
}
