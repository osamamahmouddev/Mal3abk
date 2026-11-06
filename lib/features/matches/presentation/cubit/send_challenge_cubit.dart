import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/send_challenge_request_body.dart';
import '../../domain/use_cases/send_challenge_use_case.dart';
import 'send_challenge_state.dart';

class SendChallengeCubit extends Cubit<SendChallengeState>
    with SafeEmitCubitMixin<SendChallengeState> {
  SendChallengeCubit({required this.sendChallengeUseCase})
    : super(const SendChallengeState.initial());

  final SendChallengeUseCase sendChallengeUseCase;

  Future<void> send(SendChallengeRequestBody body) async {
    if (state is SendChallengeLoading) return;
    emitIfOpen(const SendChallengeState.loading());
    final result = await sendChallengeUseCase(body);
    result.when(
      success: (challenge) => emitIfOpen(SendChallengeState.success(challenge)),
      failure: (failure) =>
          emitIfOpen(SendChallengeState.error(failure.message)),
    );
  }
}
