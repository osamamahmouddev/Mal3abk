import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/venue_dashboard_model.dart';

/// Today's money and this month's confirmed revenue (owners only: the API
/// leaves it out for staff who may not see money).
class VenueFinanceStripWidget extends StatelessWidget {
  const VenueFinanceStripWidget({
    required this.today,
    required this.month,
    super.key,
  });

  final DashboardRevenueModel today;
  final DashboardRevenueModel month;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.overview.finance.$key'.tr(context: context);
    String m(double v, String c) => VenueFormat.money(context, v, c);
    final items = [
      (
        t('confirmed_today'),
        m(today.confirmedValue, today.currency),
        AppColors.white,
      ),
      (
        t('deposits_collected'),
        m(today.depositsCollected, today.currency),
        AppColors.successBorder,
      ),
      (t('due_at_venue'), m(today.dueAtVenue, today.currency), AppColors.white),
      (
        t('deposits_pending'),
        m(today.depositsPendingReview, today.currency),
        AppColors.accentGold,
      ),
      (
        t('month_confirmed'),
        m(month.confirmedValue, month.currency),
        AppColors.white,
      ),
    ];

    return Semantics(
      container: true,
      label: t('label'),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.brandNavy,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Wrap(
          spacing: 12.w,
          runSpacing: 14.h,
          children: [
            for (final (label, value, color) in items)
              SizedBox(
                width: 140.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.onNavySubtle,
                      ),
                    ),
                    hSpace(4),
                    Text(
                      value,
                      style: AppTextStyles.font16Bold.copyWith(color: color),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
