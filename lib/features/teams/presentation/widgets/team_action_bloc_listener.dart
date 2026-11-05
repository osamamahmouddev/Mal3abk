import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/team_action_cubit.dart';
import '../cubit/team_action_state.dart';
import '../cubit/team_action_type.dart';

/// Reports the outcome of a team action and calls [onSuccess] so the screen
/// can reload or leave.
class TeamActionBlocListener extends StatelessWidget {
  const TeamActionBlocListener({
    required this.child,
    required this.onSuccess,
    super.key,
  });

  final Widget child;
  final void Function(TeamActionType action) onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeamActionCubit, TeamActionState>(
      listener: (context, state) {
        switch (state) {
          case TeamActionSuccess(:final action):
            HapticFeedback.mediumImpact();
            AppTopSnackBar.showSuccess(
              context,
              'teams.actions.${action.name}'.tr(context: context),
            );
            onSuccess(action);
          case TeamActionError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
