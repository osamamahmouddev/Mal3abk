import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/radio_option_card_widget.dart';
import '../widgets/deposit_step_widget.dart';
import '../widgets/deposit_summary_card_widget.dart';
import '../widgets/deposit_timer_banner_widget.dart';
import '../widgets/deposit_wallet_card_widget.dart';

class DepositInstructionsScreen extends HookWidget {
  const DepositInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isInstapay = useState(false);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.deposit.title'.tr(context: context),
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: 'booking.deposit.cta'.tr(context: context),
              height: 52.h,
              borderRadius: 16,
              boxShadow: AppShadows.redGlow,
              icon: SvgPicture.asset(AppAssets.icUploadWhite, width: 20.r, height: 20.r),
              textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.uploadProof),
            ),
            hSpace(8),
            CustomButton(
              text: 'booking.deposit.cancel_request'.tr(context: context),
              type: CustomButtonType.ghost,
              height: 44.h,
              textStyle: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.redText,
              ),
              onTap: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        children: [
          const DepositTimerBannerWidget(remaining: '٢٨:٤٥'),
          hSpace(12),
          const DepositSummaryCardWidget(),
          hSpace(12),
          Text(
            'booking.deposit.choose_method'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(12),
          RadioOptionCardWidget(
            title: 'booking.deposit.vodafone'.tr(context: context),
            subtitle: 'booking.deposit.vodafone_sub'.tr(context: context),
            isSelected: !isInstapay.value,
            onTap: () => isInstapay.value = false,
          ),
          hSpace(8),
          RadioOptionCardWidget(
            title: 'booking.deposit.instapay'.tr(context: context),
            subtitle: 'booking.deposit.instapay_sub'.tr(context: context),
            isSelected: isInstapay.value,
            onTap: () => isInstapay.value = true,
          ),
          hSpace(12),
          const DepositWalletCardWidget(),
          hSpace(12),
          Text(
            'booking.deposit.steps'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(14),
          for (final (number, key) in const [('١', 'step1'), ('٢', 'step2'), ('٣', 'step3')]) ...[
            DepositStepWidget(
              number: number,
              text: 'booking.deposit.$key'.tr(context: context),
            ),
            hSpace(10),
          ],
        ],
      ),
    );
  }
}
