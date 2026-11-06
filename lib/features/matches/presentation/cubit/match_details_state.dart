import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/match_details_model.dart';

part 'match_details_state.freezed.dart';

@freezed
sealed class MatchDetailsState with _$MatchDetailsState {
  const factory MatchDetailsState.initial() = MatchDetailsInitial;
  const factory MatchDetailsState.loading() = MatchDetailsLoading;
  const factory MatchDetailsState.success(MatchDetailsModel details) =
      MatchDetailsSuccess;
  const factory MatchDetailsState.error(String message) = MatchDetailsError;
}
