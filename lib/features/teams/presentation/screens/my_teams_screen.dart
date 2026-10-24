import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class MyTeamsScreen extends StatefulWidget {
  const MyTeamsScreen({super.key});

  @override
  State<MyTeamsScreen> createState() => _MyTeamsScreenState();
}

class _MyTeamsScreenState extends State<MyTeamsScreen> {
  int _selectedTab = 0; // 0: فرقي, 1: اكتشف فرق

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'فرقي',
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.rankings),
            child: Text('الترتيب', style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.brandNavy)),
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
            // Tabs
            Container(
              color: AppColors.white,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab == 0 ? AppColors.brandNavy : Colors.transparent,
                              width: 3.h,
                            ),
                          ),
                        ),
                        child: Text(
                          'فرقي',
                          style: _selectedTab == 0
                              ? AppTextStyles.font14Bold.copyWith(color: AppColors.brandNavy)
                              : AppTextStyles.font14Medium.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab == 1 ? AppColors.brandNavy : Colors.transparent,
                              width: 3.h,
                            ),
                          ),
                        ),
                        child: Text(
                          'اكتشف فرق',
                          style: _selectedTab == 1
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
                  // Team Invitation Card
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
                            SizedBox(width: 10.w),
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
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomButton(
                                text: 'رفض',
                                type: CustomButtonType.outline,
                                height: 40.h,
                                onTap: () {},
                              ),
                            ),
                            SizedBox(width: 8.w),
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
                  SizedBox(height: 14.h),

                  // Main Team Card (Figma 10:312)
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
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('فريق النجوم', style: AppTextStyles.font16Bold),
                                      SizedBox(width: 8.w),
                                      const AppBadgeWidget(text: 'كابتن', type: AppBadgeType.warning),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Text('مدينة نصر · ٨ أعضاء', style: AppTextStyles.font12Regular),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        // Stats row
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: AppColors.lightSurface,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStat('١٤', 'فوز'),
                              _buildStat('٣', 'تعادل'),
                              _buildStat('٥', 'خسارة'),
                              _buildStat('#٤', 'الترتيب', isRank: true),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrayBackground,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.sports_soccer_rounded, size: 16.sp, color: AppColors.brandNavy),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  'تحدي مع الصقور مستني حجز الملعب — السبت ٢ أغسطس',
                                  style: AppTextStyles.font12Medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'تحدي جديد',
                                type: CustomButtonType.secondary,
                                height: 44.h,
                                onTap: () => Navigator.of(context).pushNamed(AppRoutes.challengeTeam),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomButton(
                                text: 'إدارة الفريق',
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

  Widget _buildStat(String val, String label, {bool isRank = false}) {
    return Column(
      children: [
        Text(
          val,
          style: AppTextStyles.font16Bold.copyWith(
            color: isRank ? AppColors.brandRed : AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(label, style: AppTextStyles.font11Regular),
      ],
    );
  }
}

