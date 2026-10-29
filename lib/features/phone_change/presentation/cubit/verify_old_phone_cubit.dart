import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/verify_old_phone_use_case.dart';
import 'verify_old_phone_state.dart';

class VerifyOldPhoneCubit extends Cubit<VerifyOldPhoneState>
    with SafeEmitCubitMixin<VerifyOldPhoneState> {
  VerifyOldPhoneCubit({required this.verifyOldPhoneUseCase})
    : super(const VerifyOldPhoneState.initial());

  final VerifyOldPhoneUseCase verifyOldPhoneUseCase;

  Future<void> verify({required String requestId, required String code}) async {
    if (state is VerifyOldPhoneLoading) return;
    emitIfOpen(const VerifyOldPhoneState.loading());
    final result = await verifyOldPhoneUseCase(
      requestId: requestId,
      code: code,
    );
    result.when(
      success: (_) => emitIfOpen(const VerifyOldPhoneState.success()),
      failure: (failure) =>
          emitIfOpen(VerifyOldPhoneState.error(failure.message)),
    );
  }
}
