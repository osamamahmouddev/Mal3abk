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

  Future<void> start(String newPhoneNumber) async {
    if (state is StartPhoneChangeLoading) return;
    emitIfOpen(const StartPhoneChangeState.loading());
    final result = await startPhoneChangeUseCase(newPhoneNumber);
    result.when(
      success: (data) => emitIfOpen(StartPhoneChangeState.success(data)),
      failure: (failure) =>
          emitIfOpen(StartPhoneChangeState.error(failure.message)),
    );
  }
}
