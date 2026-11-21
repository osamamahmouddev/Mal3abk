import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import 'teams_action_card_widget.dart';

/// "New team" and "join by code" as two cards under the teams title.
class TeamsQuickActionsWidget extends StatelessWidget {
  const TeamsQuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 8.h),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FadeSlideInWidget(
                child: TeamsActionCardWidget(
                  filled: true,
                  icon: Icons.add_rounded,
                  title: 'teams.list.new_team'.tr(context: context),
                  hint: 'teams.list.new_team_hint'.tr(context: context),
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.createTeam),
                ),
              ),
            ),
            vSpace(10),
            Expanded(
              child: FadeSlideInWidget(
                index: 1,
                child: TeamsActionCardWidget(
                  icon: Icons.vpn_key_outlined,
                  title: 'teams.list.join_code'.tr(context: context),
                  hint: 'teams.list.join_code_hint'.tr(context: context),
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.joinTeamByCode),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
