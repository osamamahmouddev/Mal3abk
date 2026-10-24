import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/login_request_body.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with SafeEmitCubitMixin<LoginState> {
  LoginCubit({required this.loginUseCase}) : super(const LoginState.initial());

  final LoginUseCase loginUseCase;

  Future<void> login(LoginRequestBody body) async {
    emitIfOpen(const LoginState.loading());
    final result = await loginUseCase(body);
    result.when(
      success: (user) => emitIfOpen(LoginState.success(user)),
      failure: (failure) => emitIfOpen(LoginState.error(failure.message)),
    );
  }
}
