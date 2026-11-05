import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';
import '../../../../core/widgets/press_scale_widget.dart';
import '../../data/models/team_discovery_model.dart';

class DiscoverTeamCardWidget extends StatelessWidget {
  const DiscoverTeamCardWidget({required this.team, super.key});

  final TeamDiscoveryModel team;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return PressScaleWidget(
      child: GestureDetector(
        onTap: () => Navigator.of(
          context,
        ).pushNamed(AppRoutes.teamProfile, arguments: team.id),
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.borderCard),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            children: [
              InitialsAvatarWidget(
                initials: team.name.initials,
                color: AppColors.brandNavy,
                size: 46,
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(team.name, style: AppTextStyles.font15Bold),
                    hSpace(4),
                    Text(
                      'teams.common.meta_members'.tr(
                        context: context,
                        args: [
                          team.district ?? team.city,
                          team.memberCount.toLocalizedDigits(lang),
                        ],
                      ),
                      style: AppTextStyles.font12Regular,
                    ),
                    hSpace(8),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: [
                        if (team.isRecruiting)
                          AppBadgeWidget(
                            text: 'teams.list.recruiting'.tr(context: context),
                            type: AppBadgeType.success,
                          ),
                        if (team.canBeChallenged)
                          AppBadgeWidget(
                            text: 'teams.list.open_challenges'.tr(
                              context: context,
                            ),
                            type: AppBadgeType.warning,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    team.rating.round().toLocalizedDigits(lang),
                    style: AppTextStyles.font16Bold.copyWith(
                      color: AppColors.goldDark,
                    ),
                  ),
                  Text(
                    'teams.common.rating'.tr(context: context),
                    style: AppTextStyles.font11Regular,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
