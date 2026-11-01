import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/check_auth_status_use_case.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState>
    with SafeEmitCubitMixin<SplashState> {
  SplashCubit({
    required this.checkAuthStatusUseCase,
    this.delay = const Duration(seconds: 2),
  }) : super(const SplashState.initial());

  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final Duration delay;

  Future<void> checkAuth() async {
    emitIfOpen(const SplashState.loading());
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    final isAuthed = await checkAuthStatusUseCase();
    if (isAuthed) {
      emitIfOpen(const SplashState.authenticated());
    } else {
      emitIfOpen(const SplashState.unauthenticated());
    }
  }
}
