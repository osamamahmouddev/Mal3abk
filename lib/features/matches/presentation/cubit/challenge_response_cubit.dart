import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/respond_to_challenge_request_body.dart';
import '../../data/models/team_challenge_model.dart';
import '../../domain/use_cases/respond_to_challenge_use_case.dart';
import 'challenge_response_state.dart';

class ChallengeResponseCubit extends Cubit<ChallengeResponseState>
    with SafeEmitCubitMixin<ChallengeResponseState> {
  ChallengeResponseCubit({required this.respondToChallengeUseCase})
    : super(const ChallengeResponseState.initial());

  final RespondToChallengeUseCase respondToChallengeUseCase;

  Future<void> accept(String challengeId, String teamId) => _run(
    ChallengeResponseAction.accept,
    () => respondToChallengeUseCase.accept(challengeId, teamId),
  );

  Future<void> decline(String challengeId, String teamId) => _run(
    ChallengeResponseAction.decline,
    () => respondToChallengeUseCase.decline(challengeId, teamId),
  );

  Future<void> counterPropose(
    String challengeId,
    String teamId, {
    required DateTime proposedUtc,
    required int durationMinutes,
  }) => _run(
    ChallengeResponseAction.counterPropose,
    () => respondToChallengeUseCase.counterPropose(
      challengeId,
      teamId,
      proposedUtc: proposedUtc,
      durationMinutes: durationMinutes,
    ),
  );

  Future<void> _run(
    ChallengeResponseAction action,
    Future<ApiResult<TeamChallengeModel>> Function() call,
  ) async {
    if (state is ChallengeResponseLoading) return;
    emitIfOpen(const ChallengeResponseState.loading());
    final result = await call();
    result.when(
      success: (challenge) =>
          emitIfOpen(ChallengeResponseState.success(challenge, action)),
      failure: (failure) =>
          emitIfOpen(ChallengeResponseState.error(failure.message)),
    );
  }
}
