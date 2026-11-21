import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/team_invite_preview_model.dart';

part 'team_invite_preview_state.freezed.dart';

/// The team behind the code being entered or opened from a link.
@freezed
sealed class TeamInvitePreviewState with _$TeamInvitePreviewState {
  /// No complete code yet.
  const factory TeamInvitePreviewState.initial() = TeamInvitePreviewInitial;
  const factory TeamInvitePreviewState.loading() = TeamInvitePreviewLoading;
  const factory TeamInvitePreviewState.success(TeamInvitePreviewModel preview) =
      TeamInvitePreviewSuccess;

  /// [message] is a translation key.
  const factory TeamInvitePreviewState.error(String message) =
      TeamInvitePreviewError;
}
