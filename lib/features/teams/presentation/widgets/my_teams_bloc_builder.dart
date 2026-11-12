import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/state_switcher_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/my_teams_cubit.dart';
import '../cubit/my_teams_state.dart';
import 'my_team_card_widget.dart';

class MyTeamsBlocBuilder extends StatelessWidget {
  const MyTeamsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTeamsCubit, MyTeamsState>(
      builder: (context, state) {
        return StateSwitcherWidget(
          stateKey: state.runtimeType,
          child: switch (state) {
            MyTeamsSuccess(:final teams) when teams.isEmpty =>
              CustomStateWidget(
                title: 'teams.list.empty_title'.tr(context: context),
                description: 'teams.list.empty_desc'.tr(context: context),
                actionText: 'teams.list.new_team'.tr(context: context),
                onActionTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.createTeam),
              ),
            MyTeamsSuccess(:final teams) => RefreshIndicator.adaptive(
              onRefresh: () => context.read<MyTeamsCubit>().load(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.all(16.r),
                itemCount: teams.length,
                separatorBuilder: (_, _) => hSpace(12),
                itemBuilder: (_, index) => FadeSlideInWidget(
                  index: index,
                  child: MyTeamCardWidget(team: teams[index]),
                ),
              ),
            ),
            MyTeamsError(:final message) => CustomStateWidget(
              title: message.tr(context: context),
              description: '',
              actionText: 'common.retry'.tr(context: context),
              onActionTap: () => context.read<MyTeamsCubit>().load(),
            ),
            _ => const ShimmerListSkeletonWidget(itemHeight: 196, itemCount: 2),
          },
        );
      },
    );
  }
}
