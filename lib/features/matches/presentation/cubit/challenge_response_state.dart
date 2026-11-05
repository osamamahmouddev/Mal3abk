import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/respond_to_challenge_request_body.dart';
import '../../data/models/team_challenge_model.dart';

part 'challenge_response_state.freezed.dart';

@freezed
sealed class ChallengeResponseState with _$ChallengeResponseState {
  const factory ChallengeResponseState.initial() = ChallengeResponseInitial;
  const factory ChallengeResponseState.loading() = ChallengeResponseLoading;
  const factory ChallengeResponseState.success(
    TeamChallengeModel challenge,
    ChallengeResponseAction action,
  ) = ChallengeResponseSuccess;
  const factory ChallengeResponseState.error(String message) =
      ChallengeResponseError;
}
