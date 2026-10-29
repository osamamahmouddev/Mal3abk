import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/recover_phone_use_case.dart';
import 'recover_phone_state.dart';

class RecoverPhoneCubit extends Cubit<RecoverPhoneState>
    with SafeEmitCubitMixin<RecoverPhoneState> {
  RecoverPhoneCubit({required this.recoverPhoneUseCase})
    : super(const RecoverPhoneState.initial());

  final RecoverPhoneUseCase recoverPhoneUseCase;

  Future<void> recover(String recoveryToken) async {
    if (state is RecoverPhoneLoading) return;
    emitIfOpen(const RecoverPhoneState.loading());
    final result = await recoverPhoneUseCase(recoveryToken);
    result.when(
      success: (_) => emitIfOpen(const RecoverPhoneState.success()),
      failure: (failure) =>
          emitIfOpen(RecoverPhoneState.error(failure.message)),
    );
  }
}
