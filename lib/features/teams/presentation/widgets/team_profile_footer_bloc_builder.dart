import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/team_dashboard_cubit.dart';
import '../cubit/team_dashboard_state.dart';
import 'team_profile_footer_widget.dart';

class TeamProfileFooterBlocBuilder extends StatelessWidget {
  const TeamProfileFooterBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamDashboardCubit, TeamDashboardState>(
      builder: (context, state) => switch (state) {
        TeamDashboardSuccess(:final dashboard) => TeamProfileFooterWidget(
          profile: dashboard.profile,
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
