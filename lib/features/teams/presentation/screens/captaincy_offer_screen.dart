import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/captaincy_offer_hero_widget.dart';
import '../widgets/captaincy_perk_item_widget.dart';

class CaptaincyOfferScreen extends StatelessWidget {
  const CaptaincyOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'teams.captaincy.$key'.tr(context: context);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(title: t('title')),
      bottomNavigationBar: BottomActionBarWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: t('accept'),
              type: CustomButtonType.secondary,
              height: 52.h,
              borderRadius: 16,
              textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
            hSpace(8),
            CustomButton(
              text: t('decline'),
              type: CustomButtonType.outline,
              height: 46.h,
              borderRadius: 14,
              backgroundColor: AppColors.white,
              textStyle: AppTextStyles.font14SemiBold.copyWith(color: AppColors.brandNavy),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        children: [
          const CaptaincyOfferHeroWidget(),
          hSpace(14),
          CustomCardWidget(
            padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(t('perks_title'), style: AppTextStyles.font15Bold),
                for (final perk in const ['perk1', 'perk2', 'perk3', 'perk4']) ...[
                  hSpace(12),
                  CaptaincyPerkItemWidget(text: t(perk)),
                ],
                hSpace(12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    t('note'),
                    style: AppTextStyles.font13Regular.copyWith(
                      color: AppColors.textBody,
                      height: 20 / 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
