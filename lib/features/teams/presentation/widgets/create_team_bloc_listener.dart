import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/create_team_cubit.dart';
import '../cubit/create_team_state.dart';

class CreateTeamBlocListener extends StatelessWidget {
  const CreateTeamBlocListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTeamCubit, CreateTeamState>(
      listener: (context, state) {
        switch (state) {
          case CreateTeamSuccess(:final team, :final settingsSaved):
            HapticFeedback.mediumImpact();
            if (!settingsSaved) {
              AppTopSnackBar.showError(
                context,
                'errors.teams.settings_not_saved'.tr(context: context),
              );
            }
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.teamProfile, arguments: team.id);
          case CreateTeamError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
