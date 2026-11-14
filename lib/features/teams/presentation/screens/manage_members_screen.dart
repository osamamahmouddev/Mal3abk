import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/app_header_icon_button_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../cubit/team_action_type.dart';
import '../cubit/team_dashboard_cubit.dart';
import '../widgets/manage_members_bloc_builder.dart';
import '../widgets/team_action_bloc_listener.dart';

class ManageMembersScreen extends StatelessWidget {
  const ManageMembersScreen({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return TeamActionBlocListener(
      onSuccess: (action) => action == TeamActionType.disbandTeam
          ? Navigator.of(context).popUntil((route) => route.isFirst)
          : context.read<TeamDashboardCubit>().load(teamId),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'teams.manage.title'.tr(context: context),
          actions: [
            AppHeaderIconButtonWidget(
              iconAsset: AppAssets.icUserPlus,
              onTap: () => Navigator.of(
                context,
              ).pushNamed(AppRoutes.invitePlayers, arguments: teamId),
            ),
          ],
        ),
        body: ManageMembersBlocBuilder(teamId: teamId),
      ),
    );
  }
}
