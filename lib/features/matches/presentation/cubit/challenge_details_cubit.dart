import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_challenge_details_use_case.dart';
import 'challenge_details_state.dart';

class ChallengeDetailsCubit extends Cubit<ChallengeDetailsState>
    with SafeEmitCubitMixin<ChallengeDetailsState> {
  ChallengeDetailsCubit({required this.getChallengeDetailsUseCase})
    : super(const ChallengeDetailsState.initial());

  final GetChallengeDetailsUseCase getChallengeDetailsUseCase;

  Future<void> load(String challengeId) async {
    if (state is! ChallengeDetailsSuccess) {
      emitIfOpen(const ChallengeDetailsState.loading());
    }
    final result = await getChallengeDetailsUseCase(challengeId);
    result.when(
      success: (details) => emitIfOpen(ChallengeDetailsState.success(details)),
      failure: (failure) =>
          emitIfOpen(ChallengeDetailsState.error(failure.message)),
    );
  }
}
