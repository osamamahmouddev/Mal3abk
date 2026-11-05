import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/match_model.dart';
import 'match_result_action.dart';

part 'match_result_state.freezed.dart';

@freezed
sealed class MatchResultState with _$MatchResultState {
  const factory MatchResultState.initial() = MatchResultInitial;
  const factory MatchResultState.loading() = MatchResultLoading;
  const factory MatchResultState.success(
    MatchModel match,
    MatchResultAction action,
  ) = MatchResultSuccess;
  const factory MatchResultState.error(String message) = MatchResultError;
}
