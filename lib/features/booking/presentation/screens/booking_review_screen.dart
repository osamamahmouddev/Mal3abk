import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/icon_note_widget.dart';
import '../widgets/booking_info_card_widget.dart';
import '../widgets/booking_policy_card_widget.dart';
import '../widgets/booking_price_summary_card_widget.dart';
import '../widgets/booking_type_selector_widget.dart';

class BookingReviewScreen extends HookWidget {
  const BookingReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTeamBooking = useState(false);
    final agreedToPolicy = useState(false);
    final agreed = agreedToPolicy.value;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.review_title'.tr(context: context),
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: CustomButton(
          text: 'booking.submit_request'.tr(context: context),
          height: 52.h,
          borderRadius: 16,
          backgroundColor: agreed ? AppColors.brandRed : AppColors.border,
          boxShadow: agreed ? AppShadows.redGlow : null,
          textStyle: AppTextStyles.font16Bold.copyWith(
            color: agreed ? AppColors.white : AppColors.mapLabel,
          ),
          onTap: () {
            if (!agreed) {
              AppTopSnackBar.showError(
                context,
                'booking.agree_policy_required'.tr(context: context),
              );
              return;
            }
            Navigator.of(context).pushNamed(AppRoutes.depositInstructions);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
        children: [
          BookingTypeSelectorWidget(
            isTeamBooking: isTeamBooking.value,
            onChanged: (value) => isTeamBooking.value = value,
          ),
          hSpace(12),
          const BookingInfoCardWidget(),
          hSpace(12),
          const BookingPriceSummaryCardWidget(),
          hSpace(12),
          IconNoteWidget(
            iconAsset: AppAssets.icClock,
            text: 'booking.hold_notice'.tr(context: context),
          ),
          hSpace(12),
          BookingPolicyCardWidget(
            agreedToPolicy: agreed,
            onChanged: (value) => agreedToPolicy.value = value,
          ),
        ],
      ),
    );
  }
}
