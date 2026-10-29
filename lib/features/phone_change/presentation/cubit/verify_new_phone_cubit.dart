import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/verify_new_phone_use_case.dart';
import 'verify_new_phone_state.dart';

class VerifyNewPhoneCubit extends Cubit<VerifyNewPhoneState>
    with SafeEmitCubitMixin<VerifyNewPhoneState> {
  VerifyNewPhoneCubit({required this.verifyNewPhoneUseCase})
    : super(const VerifyNewPhoneState.initial());

  final VerifyNewPhoneUseCase verifyNewPhoneUseCase;

  Future<void> verify({required String requestId, required String code}) async {
    if (state is VerifyNewPhoneLoading) return;
    emitIfOpen(const VerifyNewPhoneState.loading());
    final result = await verifyNewPhoneUseCase(
      requestId: requestId,
      code: code,
    );
    result.when(
      success: (data) => emitIfOpen(VerifyNewPhoneState.success(data)),
      failure: (failure) =>
          emitIfOpen(VerifyNewPhoneState.error(failure.message)),
    );
  }
}
