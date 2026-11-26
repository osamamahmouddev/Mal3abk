import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../venue_format.dart';

/// One booking in a venue list: time, pitch, customer, deposit and status.
class VenueBookingRowWidget extends StatelessWidget {
  const VenueBookingRowWidget({
    required this.timeLabel,
    required this.pitchName,
    required this.customerName,
    required this.status,
    required this.isManual,
    required this.totalPrice,
    required this.depositAmount,
    required this.depositState,
    this.currency = 'EGP',
    this.onTap,
    super.key,
  });

  final String timeLabel;
  final String pitchName;
  final String customerName;
  final int status;
  final bool isManual;
  final double totalPrice;
  final double depositAmount;
  final String depositState;
  final String currency;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.booking_row.$key'.tr(context: context);
    final deposit = depositAmount > 0
        ? VenueFormat.money(context, depositAmount, currency)
        : t('no_deposit');
    final remaining = totalPrice - depositAmount;
    final depositLine = [
      deposit,
      VenueFormat.depositState(context, depositState),
      if (remaining > 0 && depositAmount > 0)
        'venue.booking_row.remaining'.tr(
          context: context,
          args: [VenueFormat.money(context, remaining, currency)],
        ),
    ].join(' · ');

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 64.w,
              child: Text(
                timeLabel,
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.brandNavy,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    [
                      if (customerName.isEmpty) '—' else customerName,
                      if (isManual) t('manual'),
                    ].join(' · '),
                    style: AppTextStyles.font14SemiBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  hSpace(2),
                  Text(
                    pitchName,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  hSpace(2),
                  Text(
                    depositLine,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            AppBadgeWidget(
              text: VenueFormat.statusLabel(
                context,
                status,
                isManual: isManual,
                deposit: depositAmount,
              ),
              type: VenueFormat.statusTone(
                status,
                isManual: isManual,
                deposit: depositAmount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
