import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';
import '../../data/models/team_profile_model.dart';
import '../widgets/leave_team_button_bloc_builder.dart';
import '../widgets/team_action_bloc_listener.dart';

class LeaveTeamScreen extends StatelessWidget {
  const LeaveTeamScreen({required this.profile, super.key});

  final TeamProfileModel profile;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'teams.leave.$key'.tr(context: context);
    final warnStyle = AppTextStyles.font13Regular.copyWith(
      color: AppColors.goldText,
      height: 21 / 13,
    );

    return TeamActionBlocListener(
      onSuccess: (_) =>
          Navigator.of(context).popUntil((route) => route.isFirst),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(title: t('title')),
        bottomNavigationBar: BottomActionBarWidget(
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: t('stay'),
                  type: CustomButtonType.outline,
                  height: 54.h,
                  borderRadius: 16,
                  textStyle: AppTextStyles.font15SemiBold.copyWith(
                    color: AppColors.brandNavy,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              vSpace(8),
              Expanded(child: LeaveTeamButtonBlocBuilder(teamId: profile.id)),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          children: [
            CustomCardWidget(
              padding: EdgeInsets.all(16.r),
              child: Row(
                children: [
                  InitialsAvatarWidget(
                    initials: profile.name.initials,
                    color: AppColors.successGreen,
                    size: 52,
                    textStyle: AppTextStyles.font18Bold,
                  ),
                  vSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name, style: AppTextStyles.font16Bold),
                        hSpace(4),
                        Text(
                          profile.district ?? profile.city,
                          style: AppTextStyles.font12Regular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            hSpace(14),
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 9.h, 16.w, 14.h),
              decoration: BoxDecoration(
                color: AppColors.goldLight,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t('warning_title'),
                    style: AppTextStyles.font14Bold.copyWith(
                      color: AppColors.goldText,
                    ),
                  ),
                  for (final key in const ['w1', 'w2', 'w3']) ...[
                    hSpace(8),
                    Text(t(key), style: warnStyle),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
