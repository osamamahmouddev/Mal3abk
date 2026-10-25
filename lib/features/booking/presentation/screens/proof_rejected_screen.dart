import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/timeline_card_widget.dart';
import '../widgets/booking_receipt_card_widget.dart';
import '../widgets/proof_rejected_banner_widget.dart';
import '../widgets/proof_rejected_summary_card_widget.dart';

class ProofRejectedScreen extends StatelessWidget {
  const ProofRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.details_title'.tr(context: context),
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: Row(
          children: [
            CustomButton(
              text: 'booking.call_venue'.tr(context: context),
              type: CustomButtonType.outline,
              width: 114.w,
              height: 54.h,
              borderRadius: 16,
              textStyle: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.brandNavy,
              ),
              onTap: () {},
            ),
            vSpace(8),
            Expanded(
              child: CustomButton(
                text: 'booking.reupload_btn'.tr(context: context),
                height: 54.h,
                borderRadius: 16,
                boxShadow: AppShadows.redGlow,
                textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.uploadProof),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        children: [
          const ProofRejectedBannerWidget(),
          hSpace(12),
          const ProofRejectedSummaryCardWidget(),
          hSpace(12),
          const BookingReceiptCardWidget(),
          hSpace(12),
          TimelineCardWidget(
            title: 'booking.log.title'.tr(context: context),
            entries: [
              ('booking.log.sent'.tr(context: context), 'booking.log.t_640'.tr(context: context), AppColors.brandNavy, null),
              ('booking.log.uploaded'.tr(context: context), 'booking.log.t_655'.tr(context: context), AppColors.brandNavy, null),
              ('booking.log.rejected'.tr(context: context), 'booking.log.t_712'.tr(context: context), AppColors.redText, AppColors.redDark),
            ],
          ),
        ],
      ),
    );
  }
}
