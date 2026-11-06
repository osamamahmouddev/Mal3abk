import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/account_repo.dart';
import 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState>
    with SafeEmitCubitMixin<SessionsState> {
  SessionsCubit({required this.accountRepo})
    : super(const SessionsState.initial());

  final AccountRepo accountRepo;

  Future<void> load() async {
    if (state is! SessionsSuccess) emitIfOpen(const SessionsState.loading());
    final result = await accountRepo.getSessions();
    result.when(
      success: (sessions) => emitIfOpen(
        SessionsState.success(
          [...sessions]..sort((a, b) {
            if (a.isCurrent != b.isCurrent) return a.isCurrent ? -1 : 1;
            return b.lastActivityAtUtc.compareTo(a.lastActivityAtUtc);
          }),
        ),
      ),
      failure: (failure) => emitIfOpen(SessionsState.error(failure.message)),
    );
  }

  Future<void> revoke(String sessionId) =>
      _run(() => accountRepo.revokeSession(sessionId));

  Future<void> revokeOthers() => _run(accountRepo.revokeOtherSessions);

  Future<void> _run(Future<ApiResult<void>> Function() call) async {
    final current = state;
    if (current is! SessionsSuccess || current.busy) return;
    emitIfOpen(current.copyWith(busy: true, failure: null));
    final result = await call();
    await result.when(
      success: (_) => load(),
      failure: (failure) async =>
          emitIfOpen(current.copyWith(busy: false, failure: failure.message)),
    );
  }
}
