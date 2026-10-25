import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';
import 'my_team_card_actions_widget.dart';
import 'team_stat_widget.dart';

class MyTeamCardWidget extends StatelessWidget {
  const MyTeamCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderCard),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              children: [
                InitialsAvatarWidget(
                  initials: 'teams.sample.nogoum_i'.tr(context: context),
                  color: AppColors.brandRed,
                  size: 48,
                ),
                vSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('teams.list.sample_team'.tr(context: context), style: AppTextStyles.font16Bold),
                      hSpace(4),
                      Text('teams.list.sample_meta'.tr(context: context), style: AppTextStyles.font12Regular),
                    ],
                  ),
                ),
                AppBadgeWidget(
                  text: 'teams.list.captain'.tr(context: context),
                  type: AppBadgeType.warning,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                ),
              ],
            ),
          ),
          Container(
            height: 62.h,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.lightSurface)),
            ),
            child: Row(
              children: [
                Expanded(child: TeamStatWidget(value: '١٤', label: 'teams.wins'.tr(context: context))),
                Expanded(child: TeamStatWidget(value: '٣', label: 'teams.draws'.tr(context: context))),
                Expanded(child: TeamStatWidget(value: '٥', label: 'teams.losses'.tr(context: context))),
                Expanded(
                  child: TeamStatWidget(
                    value: '#٤',
                    label: 'teams.rank'.tr(context: context),
                    isRank: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 39.h,
            color: AppColors.goldLight,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'teams.list.sample_alert'.tr(context: context),
              style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.goldText),
            ),
          ),
          MyTeamCardActionsWidget(
            onTeamPage: () => Navigator.of(context).pushNamed(AppRoutes.teamProfile),
            onManage: () => Navigator.of(context).pushNamed(AppRoutes.manageMembers),
          ),
        ],
      ),
    );
  }
}
