import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/animations/fade_indexed_stack_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/page_title_header_widget.dart';
import '../../../../core/widgets/refresh_on_return_widget.dart';
import '../cubit/discover_teams_cubit.dart';
import '../cubit/my_teams_cubit.dart';
import '../widgets/discover_teams_tab_widget.dart';
import '../widgets/my_teams_bloc_builder.dart';
import '../widgets/my_teams_header_actions_widget.dart';
import '../widgets/teams_quick_actions_widget.dart';

class MyTeamsScreen extends HookWidget {
  const MyTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    // Leaving, closing or joining a team happens on other screens (or in
    // another tab); both lists catch up when this page is back in view.
    return RefreshOnReturnWidget(
      onReturn: () {
        context.read<MyTeamsCubit>().load();
        context.read<DiscoverTeamsCubit>().refresh();
      },
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        body: Column(
          children: [
            PageTitleHeaderWidget(
              title: 'teams.my_teams_title'.tr(context: context),
              trailing: const MyTeamsHeaderActionsWidget(),
              bottom: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TeamsQuickActionsWidget(),
                  CustomTabBarWidget(
                    tabs: [
                      'teams.list.tab_mine'.tr(context: context),
                      'teams.list.tab_discover'.tr(context: context),
                    ],
                    selectedIndex: selectedTab.value,
                    indicatorColor: AppColors.brandNavy,
                    showTopBorder: false,
                    large: true,
                    onTabSelected: (index) => selectedTab.value = index,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FadeIndexedStackWidget(
                index: selectedTab.value,
                children: const [
                  MyTeamsBlocBuilder(),
                  DiscoverTeamsTabWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
