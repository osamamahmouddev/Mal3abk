import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/team_stat_widget.dart';

class MyTeamsScreen extends HookWidget {
  const MyTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.my_teams_title'.tr(context: context),
        actions: [
          CustomButton(
            text: 'teams.rankings_title'.tr(context: context),
            type: CustomButtonType.ghost,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.rankings),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_rounded, color: AppColors.brandNavy),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.joinTeamByCode),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.createTeam),
        backgroundColor: AppColors.brandRed,
        icon: const Icon(Icons.add_rounded, color: AppColors.white),
        label: Text('فريق جديد', style: AppTextStyles.font14Bold.copyWith(color: AppColors.white)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => selectedTab.value = 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedTab.value == 0 ? AppColors.brandNavy : Colors.transparent,
                              width: 3.h,
                            ),
                          ),
                        ),
                        child: Text(
                          'teams.my_teams_title'.tr(context: context),
                          style: selectedTab.value == 0
                              ? AppTextStyles.font14Bold.copyWith(color: AppColors.brandNavy)
                              : AppTextStyles.font14Medium.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => selectedTab.value = 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedTab.value == 1 ? AppColors.brandNavy : Colors.transparent,
                              width: 3.h,
                            ),
                          ),
                        ),
                        child: Text(
                          'اكتشف فرق',
                          style: selectedTab.value == 1
                              ? AppTextStyles.font14Bold.copyWith(color: AppColors.brandNavy)
                              : AppTextStyles.font14Medium.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                children: [
                  CustomCardWidget(
                    backgroundColor: AppColors.goldLight,
                    borderColor: AppColors.goldBorder,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: AppColors.brandNavy,
                              child: Text('أب', style: AppTextStyles.font12Bold.copyWith(color: AppColors.white)),
                            ),
                            vSpace(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('دعوة جديدة للانضمام', style: AppTextStyles.font12Bold.copyWith(color: AppColors.goldDark)),
                                  Text('كريم عادل دعاك لفريق الأبطال', style: AppTextStyles.font14Bold),
                                  Text('مصر الجديدة · ٦ أعضاء · فريق عام', style: AppTextStyles.font12Regular),
                                ],
                              ),
                            ),
                          ],
                        ),
                        hSpace(12),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomButton(
                                text: 'common.cancel'.tr(context: context),
                                type: CustomButtonType.outline,
                                height: 40.h,
                                onTap: () {},
                              ),
                            ),
                            vSpace(8),
                            Expanded(
                              flex: 2,
                              child: CustomButton(
                                text: 'انضم للفريق',
                                type: CustomButtonType.primary,
                                height: 40.h,
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  hSpace(14),
                  CustomCardWidget(
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.teamProfile),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundColor: AppColors.brandNavy,
                              child: Text('نج', style: AppTextStyles.font16Bold.copyWith(color: AppColors.white)),
                            ),
                            vSpace(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('فريق النجوم', style: AppTextStyles.font16Bold),
                                      vSpace(8),
                                      const AppBadgeWidget(text: 'كابتن', type: AppBadgeType.warning),
                                    ],
                                  ),
                                  hSpace(2),
                                  Text('مدينة نصر · ٨ أعضاء', style: AppTextStyles.font12Regular),
                                ],
                              ),
                            ),
                          ],
                        ),
                        hSpace(14),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: AppColors.lightSurface,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TeamStatWidget(value: '١٤', label: 'teams.wins'.tr(context: context)),
                              TeamStatWidget(value: '٣', label: 'teams.draws'.tr(context: context)),
                              TeamStatWidget(value: '٥', label: 'teams.losses'.tr(context: context)),
                              TeamStatWidget(value: '#٤', label: 'teams.rank'.tr(context: context), isRank: true),
                            ],
                          ),
                        ),
                        hSpace(12),
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrayBackground,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.sports_soccer_rounded, size: 16.sp, color: AppColors.brandNavy),
                              vSpace(6),
                              Expanded(
                                child: Text(
                                  'تحدي مع الصقور مستني حجز الملعب — السبت ٢ أغسطس',
                                  style: AppTextStyles.font12Medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        hSpace(14),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'matches.challenge_team_title'.tr(context: context),
                                type: CustomButtonType.secondary,
                                height: 44.h,
                                onTap: () => Navigator.of(context).pushNamed(AppRoutes.challengeTeam),
                              ),
                            ),
                            vSpace(10),
                            Expanded(
                              child: CustomButton(
                                text: 'teams.manage_members_title'.tr(context: context),
                                type: CustomButtonType.outline,
                                height: 44.h,
                                onTap: () => Navigator.of(context).pushNamed(AppRoutes.manageMembers),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
