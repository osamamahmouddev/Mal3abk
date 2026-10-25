import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/attendance_chip_widget.dart';

class ChallengeDetailsScreen extends StatelessWidget {
  const ChallengeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'matches.challenge_details_title'.tr(context: context),
      ),
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
                    hSpace(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('النجوم', style: AppTextStyles.font16Bold),
                        Text(
                          'common.vs'.tr(context: context),
                          style: AppTextStyles.font14Bold.copyWith(color: AppColors.textSecondary),
                        ),
                        Text('الصقور', style: AppTextStyles.font16Bold),
                      ],
                    ),
                    const Divider(height: 24, color: AppColors.border),
                    Text('ملعب النجوم — ملعب ١ · ٥ لاعب', style: AppTextStyles.font13SemiBold),
                  ],
                ),
              ),
              hSpace(14),
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
              hSpace(16),
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
                    hSpace(12),
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
                        vSpace(10),
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
                    hSpace(12),
                    const Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        AttendanceChipWidget(name: '✓ أحمد (أنت)', isComing: true),
                        AttendanceChipWidget(name: '✓ كريم', isComing: true),
                        AttendanceChipWidget(name: '✓ محمد', isComing: true),
                        AttendanceChipWidget(name: '✓ يوسف', isComing: true),
                        AttendanceChipWidget(name: '✕ عمر', isComing: false),
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
}
