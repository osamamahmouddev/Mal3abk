import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.brandNavy,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 36.r,
                          backgroundColor: AppColors.white,
                          child: Text(
                            'أس',
                            style: AppTextStyles.font22Bold.copyWith(color: AppColors.brandNavy),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('أحمد سامي', style: AppTextStyles.font20Bold.copyWith(color: AppColors.white)),
                              SizedBox(height: 2.h),
                              Text('مدينة نصر · وسط · هجوم', style: AppTextStyles.font12Regular.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                              Text('عضو من مارس ٢٠٢٦', style: AppTextStyles.font11Regular.copyWith(color: AppColors.white.withValues(alpha: 0.6))),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.profileSetup),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.white),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          ),
                          child: Text('تعديل', style: AppTextStyles.font12Bold.copyWith(color: AppColors.white)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('٢٢', 'ماتش'),
                        _buildStat('٦٤٪', 'فوز'),
                        _buildStat('١٨', 'حجز'),
                        _buildStat('٢', 'فريق'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Navigation Links
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CustomCardWidget(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          _buildListTile(Icons.groups_outlined, 'فرقي', 'النجوم · الأبطال', () => Navigator.of(context).pushNamed(AppRoutes.myTeams)),
                          const Divider(height: 1, color: AppColors.border),
                          _buildListTile(Icons.calendar_today_outlined, 'سجل الحجوزات', '', () => Navigator.of(context).pushNamed(AppRoutes.myBookings)),
                          const Divider(height: 1, color: AppColors.border),
                          _buildListTile(Icons.favorite_border_rounded, 'الملاعب المفضلة', '٣', () => Navigator.of(context).pushNamed(AppRoutes.favorites)),
                          const Divider(height: 1, color: AppColors.border),
                          _buildListTile(Icons.notifications_none_rounded, 'الإشعارات', '', () => Navigator.of(context).pushNamed(AppRoutes.notifications)),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    CustomCardWidget(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          _buildListTile(Icons.settings_outlined, 'الإعدادات', 'عربي', () => Navigator.of(context).pushNamed(AppRoutes.settings)),
                          const Divider(height: 1, color: AppColors.border),
                          _buildListTile(Icons.help_outline_rounded, 'المساعدة والدعم', '', () => Navigator.of(context).pushNamed(AppRoutes.helpAndSupport)),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Venue Owner Prompt Card
                    CustomCardWidget(
                      backgroundColor: AppColors.goldLight,
                      borderColor: AppColors.goldBorder,
                      child: Row(
                        children: [
                          Icon(Icons.stadium_outlined, size: 28.sp, color: AppColors.goldDark),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('عندك ملعب؟', style: AppTextStyles.font14Bold.copyWith(color: AppColors.goldDark)),
                                Text('سجّل ملعبك وأدر حجوزاتك من لوحة ملعبك', style: AppTextStyles.font11Regular),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.goldDark),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String val, String label) {
    return Column(
      children: [
        Text(val, style: AppTextStyles.font18Bold.copyWith(color: AppColors.white)),
        SizedBox(height: 2.h),
        Text(label, style: AppTextStyles.font11Regular.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, String trailing, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.brandNavy, size: 22.sp),
      title: Text(title, style: AppTextStyles.font14Medium),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing.isNotEmpty) ...[
            Text(trailing, style: AppTextStyles.font12Regular),
            SizedBox(width: 6.w),
          ],
          Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.textSecondary),
        ],
      ),
      onTap: onTap,
    );
  }
}

