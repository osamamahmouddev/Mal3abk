import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class NotificationsPermissionScreen extends StatelessWidget {
  const NotificationsPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.brandNavy),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // Preview notifications cards stack
              _buildNotificationPreview(
                icon: Icons.check_circle_rounded,
                iconColor: AppColors.successGreen,
                title: 'اتأكد حجزك في ملعب النجوم',
                time: 'السبت ٨:٠٠ م · العربون اتعتمد',
              ),
              SizedBox(height: 10.h),
              _buildNotificationPreview(
                icon: Icons.swap_horiz_rounded,
                iconColor: AppColors.brandNavy,
                title: 'الصقور بيتحدوا فريقك',
                time: 'رد خلال ٤٨ ساعة',
              ),
              SizedBox(height: 10.h),
              _buildNotificationPreview(
                icon: Icons.alarm_rounded,
                iconColor: AppColors.brandRed,
                title: 'ماتشك بعد ٣ ساعات',
                time: 'ملعب النجوم · ملعب ١',
              ),
              SizedBox(height: 32.h),
              Text(
                'ماتفوّتش ردّ الملعب',
                style: AppTextStyles.font22Bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                'هنبعتلك إشعار لما الملعب يأكد العربون أو يرفضه، ولما فريقك يوصله تحدي، وقبل الماتش بـ٣ ساعات. تقدر تتحكم في كل نوع من الإعدادات.',
                style: AppTextStyles.font14Regular,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                text: 'فعّل الإشعارات',
                type: CustomButtonType.primary,
                height: 54.h,
                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
              ),
              SizedBox(height: 12.h),
              CustomButton(
                text: 'مش دلوقتي',
                type: CustomButtonType.ghost,
                height: 48.h,
                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationPreview({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.white,
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font13SemiBold,
                ),
                SizedBox(height: 2.h),
                Text(
                  time,
                  style: AppTextStyles.font11Regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

