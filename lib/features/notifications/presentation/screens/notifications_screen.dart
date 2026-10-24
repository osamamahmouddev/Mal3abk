import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'الإشعارات',
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'تعيين الكل كمقروء',
              style: AppTextStyles.font12Medium.copyWith(color: AppColors.brandNavy),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            _buildNotificationItem(
              context,
              icon: Icons.check_circle_rounded,
              iconColor: AppColors.successGreen,
              title: 'اتأكد حجزك في ملعب النجوم',
              time: 'منذ ١٠ دقائق · العربون اتعتمد من الملعب',
              isUnread: true,
            ),
            _buildNotificationItem(
              context,
              icon: Icons.sports_soccer_rounded,
              iconColor: AppColors.brandNavy,
              title: 'الصقور بيتحدوا فريقك في ماتش جديد',
              time: 'منذ ساعتين · السبت ٢ أغسطس ٩:٠٠ م',
              isUnread: true,
            ),
            _buildNotificationItem(
              context,
              icon: Icons.alarm_rounded,
              iconColor: AppColors.brandRed,
              title: 'ماتشك بعد ٣ ساعات في ملعب النجوم',
              time: 'منذ ٤ ساعات · ملعب ١',
              isUnread: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required bool isUnread,
  }) {
    return CustomCardWidget(
      backgroundColor: isUnread ? AppColors.white : AppColors.lightSurface,
      margin: EdgeInsets.only(bottom: 10.h),
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationDetail),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: isUnread ? AppColors.lightSurface : AppColors.white,
            child: Icon(icon, color: iconColor, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isUnread ? AppTextStyles.font14Bold : AppTextStyles.font14Medium,
                ),
                SizedBox(height: 4.h),
                Text(time, style: AppTextStyles.font11Regular),
              ],
            ),
          ),
          if (isUnread) ...[
            SizedBox(width: 8.w),
            Container(
              width: 8.w,
              height: 8.h,
              decoration: const BoxDecoration(
                color: AppColors.brandRed,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

