import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/challenge_details_model.dart';

part 'challenge_details_state.freezed.dart';

@freezed
sealed class ChallengeDetailsState with _$ChallengeDetailsState {
  const factory ChallengeDetailsState.initial() = ChallengeDetailsInitial;
  const factory ChallengeDetailsState.loading() = ChallengeDetailsLoading;
  const factory ChallengeDetailsState.success(ChallengeDetailsModel details) =
      ChallengeDetailsSuccess;
  const factory ChallengeDetailsState.error(String message) =
      ChallengeDetailsError;
}
