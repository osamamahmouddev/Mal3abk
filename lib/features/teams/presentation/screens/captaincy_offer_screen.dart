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
import '../widgets/captaincy_perk_item_widget.dart';

class CaptaincyOfferScreen extends StatelessWidget {
  const CaptaincyOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.captaincy_offer_title'.tr(context: context),
      ),
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
                text: 'teams.accept_captaincy'.tr(context: context),
                type: CustomButtonType.primary,
                height: 52.h,
                onTap: () => Navigator.of(context).pop(),
              ),
              hSpace(10),
              CustomButton(
                text: 'teams.decline_captaincy'.tr(context: context),
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
              CustomCardWidget(
                backgroundColor: AppColors.brandNavy,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36.r,
                      backgroundColor: AppColors.white,
                      child: Text(
                        'نج',
                        style: AppTextStyles.font20Bold.copyWith(
                          color: AppColors.brandNavy,
                        ),
                      ),
                    ),
                    hSpace(10),
                    const AppBadgeWidget(text: 'كابتن جديد؟', type: AppBadgeType.accent),
                    hSpace(10),
                    Text(
                      'أحمد سامي عايز يخليك كابتن فريق النجوم',
                      style: AppTextStyles.font18Bold.copyWith(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                    hSpace(6),
                    Text(
                      'العرض صالح لحد بكرة ٦:٠٠ م',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              hSpace(16),
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('لو قبلت، هتقدر:', style: AppTextStyles.font16Bold),
                    hSpace(12),
                    const CaptaincyPerkItemWidget(text: 'تقبل وتبعت تحديات باسم الفريق'),
                    const CaptaincyPerkItemWidget(text: 'تسجّل النتايج وتأكدها'),
                    const CaptaincyPerkItemWidget(text: 'تدعي لاعبين وتشيل أعضاء'),
                    const CaptaincyPerkItemWidget(text: 'تنقل الكابتنية لحد تاني بعدين'),
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
