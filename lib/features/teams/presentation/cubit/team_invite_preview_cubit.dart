import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/routes/invite_link.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/preview_team_invite_use_case.dart';
import 'team_invite_preview_state.dart';

/// Shows which team a code leads to as soon as it is complete, typed or
/// opened from a link. Only the latest code's answer is kept.
class TeamInvitePreviewCubit extends Cubit<TeamInvitePreviewState>
    with SafeEmitCubitMixin<TeamInvitePreviewState> {
  TeamInvitePreviewCubit({required this.previewTeamInviteUseCase})
    : super(const TeamInvitePreviewState.initial());

  final PreviewTeamInviteUseCase previewTeamInviteUseCase;

  String? _code;

  /// Called on every change of the code field.
  Future<void> codeChanged(String raw) async {
    final code = InviteLink.normalize(raw);
    if (code == _code) return;
    _code = code;
    if (code == null) {
      emitIfOpen(const TeamInvitePreviewState.initial());
      return;
    }
    emitIfOpen(const TeamInvitePreviewState.loading());
    final result = await previewTeamInviteUseCase(code);
    if (code != _code) return; // A newer code was entered meanwhile.
    result.when(
      success: (preview) => emitIfOpen(TeamInvitePreviewState.success(preview)),
      failure: (failure) =>
          emitIfOpen(TeamInvitePreviewState.error(failure.message)),
    );
  }
}
