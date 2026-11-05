import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_challenge_model.dart';

part 'send_challenge_state.freezed.dart';

@freezed
sealed class SendChallengeState with _$SendChallengeState {
  const factory SendChallengeState.initial() = SendChallengeInitial;
  const factory SendChallengeState.loading() = SendChallengeLoading;
  const factory SendChallengeState.success(TeamChallengeModel challenge) =
      SendChallengeSuccess;
  const factory SendChallengeState.error(String message) = SendChallengeError;
}
