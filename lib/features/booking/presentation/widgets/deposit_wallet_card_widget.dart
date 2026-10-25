import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class DepositWalletCardWidget extends StatelessWidget {
  const DepositWalletCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = 'booking.deposit.sample_wallet'.tr(context: context);
    final bookingNo = 'booking.deposit.sample_booking_no'.tr(context: context);

    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'booking.deposit.wallet_number'.tr(context: context),
            style: AppTextStyles.font12Regular,
          ),
          hSpace(10),
          Row(
            children: [
              Expanded(child: Text(wallet, style: AppTextStyles.font18Bold)),
              CustomButton(
                text: 'booking.deposit.copy'.tr(context: context),
                type: CustomButtonType.outline,
                height: 40.h,
                borderRadius: 10,
                backgroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                icon: SvgPicture.asset(AppAssets.icCopy, width: 16.r, height: 16.r),
                textStyle: AppTextStyles.font13SemiBold.copyWith(
                  color: AppColors.brandNavy,
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: wallet));
                  AppTopSnackBar.showSuccess(
                    context,
                    'booking.deposit.copied'.tr(context: context),
                  );
                },
              ),
            ],
          ),
          hSpace(10),
          Row(
            children: [
              Text(
                'booking.deposit.recipient'.tr(context: context),
                style: AppTextStyles.font14Regular,
              ),
              const Spacer(),
              Text(
                'booking.deposit.sample_recipient'.tr(context: context),
                style: AppTextStyles.font14SemiBold,
              ),
            ],
          ),
          hSpace(14),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
            decoration: BoxDecoration(
              color: AppColors.lightGrayBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              'booking.deposit.tip'.tr(context: context, args: [bookingNo]),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textBody,
                height: 21 / 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
