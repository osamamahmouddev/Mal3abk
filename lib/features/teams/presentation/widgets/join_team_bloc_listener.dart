import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/join_team_cubit.dart';
import '../cubit/join_team_state.dart';

class JoinTeamBlocListener extends StatelessWidget {
  const JoinTeamBlocListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<JoinTeamCubit, JoinTeamState>(
      listener: (context, state) {
        switch (state) {
          case JoinTeamSuccess(:final team):
            HapticFeedback.mediumImpact();
            AppTopSnackBar.showSuccess(
              context,
              'teams.join.joined'.tr(context: context, args: [team.name]),
            );
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.teamProfile, arguments: team.id);
          case JoinTeamError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
