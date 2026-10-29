import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/logout_all_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState>
    with SafeEmitCubitMixin<LogoutState> {
  LogoutCubit({required this.logoutUseCase, required this.logoutAllUseCase})
    : super(const LogoutState.initial());

  final LogoutUseCase logoutUseCase;
  final LogoutAllUseCase logoutAllUseCase;

  Future<void> logout() async {
    if (state is LogoutLoading) return;
    emitIfOpen(const LogoutState.loading());
    final result = await logoutUseCase();
    result.when(
      success: (_) => emitIfOpen(const LogoutState.success()),
      failure: (failure) => emitIfOpen(LogoutState.error(failure.message)),
    );
  }

  Future<void> logoutAll() async {
    if (state is LogoutLoading) return;
    emitIfOpen(const LogoutState.loading());
    final result = await logoutAllUseCase();
    result.when(
      success: (_) => emitIfOpen(const LogoutState.success()),
      failure: (failure) => emitIfOpen(LogoutState.error(failure.message)),
    );
  }
}
