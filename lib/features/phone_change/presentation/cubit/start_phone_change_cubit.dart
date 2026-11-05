import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/start_phone_change_use_case.dart';
import 'start_phone_change_state.dart';

class StartPhoneChangeCubit extends Cubit<StartPhoneChangeState>
    with SafeEmitCubitMixin<StartPhoneChangeState> {
  StartPhoneChangeCubit({required this.startPhoneChangeUseCase})
    : super(const StartPhoneChangeState.initial());

  final StartPhoneChangeUseCase startPhoneChangeUseCase;

  /// True when the number is valid; otherwise emits the error.
  bool validate(String newPhoneNumber) {
    final result = startPhoneChangeUseCase.validate(newPhoneNumber);
    if (result case ApiFailure(:final failure)) {
      emitIfOpen(StartPhoneChangeState.error(failure.message));
      return false;
    }
    return true;
  }

  Future<void> start(
    String newPhoneNumber, {
    required String stepUpToken,
  }) async {
    if (state is StartPhoneChangeLoading) return;
    emitIfOpen(const StartPhoneChangeState.loading());
    final result = await startPhoneChangeUseCase(
      newPhoneNumber,
      stepUpToken: stepUpToken,
    );
    result.when(
      success: (data) => emitIfOpen(StartPhoneChangeState.success(data)),
      failure: (failure) =>
          emitIfOpen(StartPhoneChangeState.error(failure.message)),
    );
  }
}
