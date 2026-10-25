import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_header_icon_button_widget.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/bullet_list_card_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/timeline_card_widget.dart';
import '../widgets/booking_details_hero_widget.dart';
import '../widgets/booking_location_card_widget.dart';
import '../widgets/booking_payment_card_widget.dart';
import '../widgets/booking_quick_action_widget.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.details_title'.tr(context: context),
        actions: [
          AppHeaderIconButtonWidget(
            iconAsset: AppAssets.icHelp,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.helpAndSupport),
          ),
        ],
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: CustomButton(
          text: 'booking.details.cancel'.tr(context: context),
          type: CustomButtonType.outline,
          height: 52.h,
          borderRadius: 12,
          borderColor: AppColors.redBorder,
          textStyle: AppTextStyles.font15Bold.copyWith(color: AppColors.redText),
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.cancelBooking),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        children: [
          const BookingDetailsHeroWidget(),
          hSpace(12),
          Row(
            children: [
              for (final (i, icon, key) in const [
                (0, AppAssets.icDirections, 'directions'),
                (1, AppAssets.icPhone, 'call'),
                (2, AppAssets.icShare, 'share'),
              ]) ...[
                if (i > 0) vSpace(8),
                Expanded(
                  child: BookingQuickActionWidget(
                    iconAsset: icon,
                    label: 'booking.details.$key'.tr(context: context),
                    onTap: () {},
                  ),
                ),
              ],
            ],
          ),
          hSpace(12),
          const BookingPaymentCardWidget(),
          hSpace(12),
          const BookingLocationCardWidget(),
          hSpace(12),
          BulletListCardWidget(
            title: 'booking.details.policy_title'.tr(context: context),
            lines: [
              'booking.details.policy1'.tr(context: context),
              'booking.details.policy2'.tr(context: context),
              'booking.details.policy3'.tr(context: context),
            ],
            footnote: 'booking.details.policy_note'.tr(context: context),
          ),
          hSpace(12),
          TimelineCardWidget(
            title: 'booking.details.log'.tr(context: context),
            compact: true,
            entries: [
              ('booking.details.log_sent'.tr(context: context), 'booking.details.t1'.tr(context: context), AppColors.brandNavy, null),
              ('booking.details.log_uploaded'.tr(context: context), 'booking.details.t2'.tr(context: context), AppColors.brandNavy, null),
              ('booking.details.log_confirmed'.tr(context: context), 'booking.details.t3'.tr(context: context), AppColors.successGreen, AppColors.textPrimary),
            ],
          ),
        ],
      ),
    );
  }
}
