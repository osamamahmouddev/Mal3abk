import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class CaptaincyOfferScreen extends StatelessWidget {
  const CaptaincyOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'عرض الكابتنية'),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: 'قبول الكابتنية',
                type: CustomButtonType.primary,
                height: 52.h,
                onTap: () => Navigator.of(context).pop(),
              ),
              SizedBox(height: 10.h),
              CustomButton(
                text: 'لأ، شكراً',
                type: CustomButtonType.ghost,
                height: 46.h,
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Offer Card
              CustomCardWidget(
                backgroundColor: AppColors.brandNavy,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36.r,
                      backgroundColor: AppColors.white,
                      child: Text('نج', style: AppTextStyles.font20Bold.copyWith(color: AppColors.brandNavy)),
                    ),
                    SizedBox(height: 10.h),
                    const AppBadgeWidget(text: 'كابتن جديد؟', type: AppBadgeType.accent),
                    SizedBox(height: 10.h),
                    Text(
                      'أحمد سامي عايز يخليك كابتن فريق النجوم',
                      style: AppTextStyles.font18Bold.copyWith(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'العرض صالح لحد بكرة ٦:٠٠ م',
                      style: AppTextStyles.font12Regular.copyWith(color: AppColors.white.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Perks
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('لو قبلت، هتقدر:', style: AppTextStyles.font16Bold),
                    SizedBox(height: 12.h),
                    _buildPerk('تقبل وتبعت تحديات باسم الفريق'),
                    SizedBox(height: 10.h),
                    _buildPerk('تسجّل النتايج وتأكدها'),
                    SizedBox(height: 10.h),
                    _buildPerk('تدعي لاعبين وتشيل أعضاء'),
                    SizedBox(height: 10.h),
                    _buildPerk('تنقل الكابتنية لحد تاني بعدين'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerk(String text) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.h,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.successLight,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check_rounded, size: 16.sp, color: AppColors.successGreen),
        ),
        SizedBox(width: 10.w),
        Expanded(child: Text(text, style: AppTextStyles.font14Regular)),
      ],
    );
  }
}

