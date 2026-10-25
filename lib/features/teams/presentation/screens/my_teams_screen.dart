import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/page_title_header_widget.dart';
import '../widgets/my_team_card_widget.dart';
import '../widgets/my_teams_header_actions_widget.dart';
import '../widgets/team_invite_card_widget.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';

class MyTeamsScreen extends HookWidget {
  const MyTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: Column(
        children: [
          PageTitleHeaderWidget(
            title: 'teams.my_teams_title'.tr(context: context),
            trailing: const MyTeamsHeaderActionsWidget(),
            bottom: CustomTabBarWidget(
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
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              children: [
                const FadeSlideInWidget(child: TeamInviteCardWidget()),
                hSpace(12),
                const FadeSlideInWidget(index: 1, child: MyTeamCardWidget()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
