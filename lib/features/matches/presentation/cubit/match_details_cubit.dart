import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_match_details_use_case.dart';
import 'match_details_state.dart';

class MatchDetailsCubit extends Cubit<MatchDetailsState>
    with SafeEmitCubitMixin<MatchDetailsState> {
  MatchDetailsCubit({required this.getMatchDetailsUseCase})
    : super(const MatchDetailsState.initial());

  final GetMatchDetailsUseCase getMatchDetailsUseCase;

  Future<void> load(String matchId) async {
    if (state is! MatchDetailsSuccess) {
      emitIfOpen(const MatchDetailsState.loading());
    }
    final result = await getMatchDetailsUseCase(matchId);
    result.when(
      success: (details) => emitIfOpen(MatchDetailsState.success(details)),
      failure: (failure) =>
          emitIfOpen(MatchDetailsState.error(failure.message)),
    );
  }
}
