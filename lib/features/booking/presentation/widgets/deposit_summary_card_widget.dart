import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import 'booking_detail_row_widget.dart';

class DepositSummaryCardWidget extends StatelessWidget {
  const DepositSummaryCardWidget({
    required this.bookingReference,
    required this.slotLabel,
    required this.totalPrice,
    required this.depositAmount,
    this.venuePayAmount,
    this.pitchName,
    super.key,
  });

  final String bookingReference;
  final String? pitchName;
  final String slotLabel;
  final double totalPrice;
  final double depositAmount;
  final double? venuePayAmount;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String egp(double value) => 'common.price_egp'.tr(
      context: context,
      args: [value.round().toLocalizedDigits(lang)],
    );
    final ref = bookingReference;
    final pitch = pitchName ?? '';
    final slot = slotLabel;
    final total = egp(totalPrice);
    final remaining = egp(venuePayAmount ?? (totalPrice - depositAmount));
    final deposit = egp(depositAmount);

    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'booking.deposit.booking_no'.tr(context: context),
                style: AppTextStyles.font13Regular,
              ),
              const Spacer(),
              Text(ref, style: AppTextStyles.font13SemiBold),
            ],
          ),
          if (pitch.isNotEmpty) ...[
            hSpace(10),
            Text(pitch, style: AppTextStyles.font16Bold),
          ],
          hSpace(12),
          Text(slot, style: AppTextStyles.font13Regular),
          hSpace(14),
          Container(height: 1, color: AppColors.border),
          hSpace(2),
          BookingDetailRowWidget(
            label: 'booking.total_price'.tr(context: context),
            value: total,
          ),
          BookingDetailRowWidget(
            label: 'booking.remaining_at_venue'.tr(context: context),
            value: remaining,
          ),
          hSpace(8),
          Container(
            height: 54.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: AppColors.goldLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Text(
                  'booking.deposit_required_now'.tr(context: context),
                  style: AppTextStyles.font15Bold.copyWith(
                    color: AppColors.goldDark,
                  ),
                ),
                const Spacer(),
                Text(
                  deposit,
                  style: AppTextStyles.font20Bold.copyWith(
                    color: AppColors.goldDark,
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
