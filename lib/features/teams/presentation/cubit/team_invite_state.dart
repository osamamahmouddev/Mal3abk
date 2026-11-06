import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_invitation_model.dart';

part 'team_invite_state.freezed.dart';

@freezed
sealed class TeamInviteState with _$TeamInviteState {
  const factory TeamInviteState.initial() = TeamInviteInitial;
  const factory TeamInviteState.loading() = TeamInviteLoading;
  const factory TeamInviteState.success(TeamInvitationModel invitation) =
      TeamInviteSuccess;
  const factory TeamInviteState.error(String message) = TeamInviteError;
}
