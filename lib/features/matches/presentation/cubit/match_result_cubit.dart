import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/match_model.dart';
import '../../data/models/verify_match_result_request_body.dart';
import '../../domain/repos/matches_repo.dart';
import 'match_result_action.dart';
import 'match_result_state.dart';

class MatchResultCubit extends Cubit<MatchResultState>
    with SafeEmitCubitMixin<MatchResultState> {
  MatchResultCubit({required this.matchesRepo})
    : super(const MatchResultState.initial());

  static const int minDisputeReasonLength = 5;

  final MatchesRepo matchesRepo;

  Future<void> submit(
    String matchId, {
    required String teamId,
    required int homeScore,
    required int awayScore,
  }) => _run(
    MatchResultAction.submitted,
    () => matchesRepo.submitResult(
      matchId,
      teamId: teamId,
      homeScore: homeScore,
      awayScore: awayScore,
    ),
  );

  Future<void> confirm(String matchId, {required String teamId}) => _run(
    MatchResultAction.confirmed,
    () => matchesRepo.verifyResult(
      matchId,
      teamId: teamId,
      action: MatchVerificationAction.confirm,
    ),
  );

  Future<void> dispute(
    String matchId, {
    required String teamId,
    required String reason,
  }) {
    final trimmed = reason.trim();
    if (trimmed.length < minDisputeReasonLength) {
      emitIfOpen(
        const MatchResultState.error('errors.matches.dispute_reason_required'),
      );
      return Future.value();
    }
    return _run(
      MatchResultAction.disputed,
      () => matchesRepo.verifyResult(
        matchId,
        teamId: teamId,
        action: MatchVerificationAction.dispute,
        disputeReason: trimmed,
      ),
    );
  }

  Future<void> _run(
    MatchResultAction action,
    Future<ApiResult<MatchModel>> Function() call,
  ) async {
    if (state is MatchResultLoading) return;
    emitIfOpen(const MatchResultState.loading());
    final result = await call();
    result.when(
      success: (match) => emitIfOpen(MatchResultState.success(match, action)),
      failure: (failure) => emitIfOpen(MatchResultState.error(failure.message)),
    );
  }
}
