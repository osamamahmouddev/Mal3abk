import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../cubit/team_dashboard_cubit.dart';
import '../widgets/team_action_bloc_listener.dart';
import '../widgets/team_dashboard_bloc_builder.dart';
import '../widgets/team_profile_footer_bloc_builder.dart';

class TeamProfileScreen extends StatelessWidget {
  const TeamProfileScreen({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return TeamActionBlocListener(
      onSuccess: (_) => context.read<TeamDashboardCubit>().load(teamId),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        bottomNavigationBar: const TeamProfileFooterBlocBuilder(),
        body: TeamDashboardBlocBuilder(teamId: teamId),
      ),
    );
  }
}
