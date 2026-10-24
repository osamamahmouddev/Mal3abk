import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class ChallengeDetailsScreen extends StatelessWidget {
  const ChallengeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'تفاصيل التحدي'),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'احجز الملعب للماتش',
            type: CustomButtonType.primary,
            height: 52.h,
            onTap: () {},
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('السبت ٢ أغسطس · ٩:٠٠ م', style: AppTextStyles.font13Regular),
                        const AppBadgeWidget(text: '✓ مقبول', type: AppBadgeType.success),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('النجوم', style: AppTextStyles.font16Bold),
                        Text('ضد', style: AppTextStyles.font14Bold.copyWith(color: AppColors.textSecondary)),
                        Text('الصقور', style: AppTextStyles.font16Bold),
                      ],
                    ),
                    const Divider(height: 24, color: AppColors.border),
                    Text('ملعب النجوم — ملعب ١ · ٥ لاعب', style: AppTextStyles.font13SemiBold),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.goldLight,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'إنت الكابتن واتفقتوا إن الحجز عليكم. احجز قبل ما الميعاد يروح — ملعب ١ لسه فاضي ٩:٠٠ م.',
                  style: AppTextStyles.font13Regular.copyWith(color: AppColors.goldDark),
                ),
              ),
              SizedBox(height: 16.h),

              // Attendance Tracker
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('مين جاي من النجوم؟', style: AppTextStyles.font15Bold),
                        Text('٤ من ٥ مطلوبين', style: AppTextStyles.font12Medium),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: '✓ جاي',
                            type: CustomButtonType.secondary,
                            height: 42.h,
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomButton(
                            text: 'مش هقدر',
                            type: CustomButtonType.outline,
                            height: 42.h,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 6.h,
                      children: [
                        _buildAttendanceChip('✓ أحمد (أنت)', true),
                        _buildAttendanceChip('✓ كريم', true),
                        _buildAttendanceChip('✓ محمد', true),
                        _buildAttendanceChip('✓ يوسف', true),
                        _buildAttendanceChip('✕ عمر', false),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceChip(String name, bool isComing) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isComing ? AppColors.successLight : AppColors.redLight,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        name,
        style: AppTextStyles.font11Bold.copyWith(
          color: isComing ? AppColors.successGreen : AppColors.redText,
        ),
      ),
    );
  }
}

