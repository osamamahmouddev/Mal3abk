import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class ChallengeReceivedScreen extends StatelessWidget {
  const ChallengeReceivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'تحدي جديد لفريقك'),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'رفض التحدي',
                  type: CustomButtonType.outline,
                  height: 52.h,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  text: 'قبول التحدي',
                  type: CustomButtonType.primary,
                  height: 52.h,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.brandNavy,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundColor: AppColors.brandRed,
                              child: Text('أس', style: AppTextStyles.font16Bold.copyWith(color: AppColors.white)),
                            ),
                            SizedBox(height: 6.h),
                            Text('أسود العباسية', style: AppTextStyles.font14Bold.copyWith(color: AppColors.white)),
                            Text('#٣ · ١٠ فوز', style: AppTextStyles.font11Regular.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                          ],
                        ),
                        Text('بيتحدوكم', style: AppTextStyles.font14Bold.copyWith(color: AppColors.accentGold)),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundColor: AppColors.white,
                              child: Text('نج', style: AppTextStyles.font16Bold.copyWith(color: AppColors.brandNavy)),
                            ),
                            SizedBox(height: 6.h),
                            Text('فريق النجوم', style: AppTextStyles.font14Bold.copyWith(color: AppColors.white)),
                            Text('فريقك', style: AppTextStyles.font11Regular.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('تفاصيل الميعاد والملعب المقترح', style: AppTextStyles.font15Bold),
                    SizedBox(height: 10.h),
                    Text('الميعاد: الجمعة ٨ أغسطس · ٩:٠٠ م', style: AppTextStyles.font13SemiBold),
                    SizedBox(height: 4.h),
                    Text('الملعب: ملعب النجوم — مدينة نصر (ملعب ١)', style: AppTextStyles.font13Regular),
                    SizedBox(height: 4.h),
                    Text('الكابتن مقدم الطلب: هيثم كمال · متبقي ٢٤ ساعة للرد', style: AppTextStyles.font12Medium),
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

