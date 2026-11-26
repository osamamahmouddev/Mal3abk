import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/venue_dashboard_model.dart';

/// Today's four headline numbers.
class VenueKpiGridWidget extends StatelessWidget {
  const VenueKpiGridWidget({required this.dashboard, super.key});

  final VenueDashboardModel dashboard;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.overview.kpi.$key'.tr(context: context);
    final nextHold =
        dashboard.timeline
            .where((b) => b.status == VenueBookingStatus.pendingDeposit)
            .map((b) => b.deadlineUtc)
            .whereType<String>()
            .toList()
          ..sort();
    final occupancy = dashboard.todayOccupancy.percent;

    final cards = [
      _Kpi(
        icon: Icons.event_available_rounded,
        label: t('today_bookings'),
        value: VenueFormat.number(context, dashboard.today.todayBookings),
        hint: 'venue.overview.kpi.confirmed_count'.tr(
          context: context,
          args: [VenueFormat.number(context, dashboard.today.confirmed)],
        ),
      ),
      _Kpi(
        icon: Icons.hourglass_top_rounded,
        label: t('pending_deposit'),
        value: VenueFormat.number(context, dashboard.today.pendingDeposit),
        hint: nextHold.isEmpty
            ? t('no_pending')
            : 'venue.overview.kpi.next_expiry'.tr(
                context: context,
                args: [VenueFormat.timeLeft(context, nextHold.first)],
              ),
      ),
      _Kpi(
        icon: Icons.receipt_long_outlined,
        label: t('proofs_review'),
        value: VenueFormat.number(
          context,
          dashboard.proofsAwaitingReview.length,
        ),
        hint: t('proofs_hint'),
      ),
      _Kpi(
        icon: Icons.speed_rounded,
        label: t('occupancy'),
        value: VenueFormat.percent(context, occupancy),
        progress: (occupancy / 100).clamp(0, 1).toDouble(),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - 10.w) / 2;
        return Wrap(
          spacing: 10.w,
          runSpacing: 10.w,
          children: [
            for (final card in cards) SizedBox(width: width, child: card),
          ],
        );
      },
    );
  }
}

class _Kpi extends StatelessWidget {
  const _Kpi({
    required this.icon,
    required this.label,
    required this.value,
    this.hint,
    this.progress,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? hint;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      padding: EdgeInsets.all(14.r),
      borderRadius: 18,
      child: Semantics(
        container: true,
        label: '$label: $value',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.font12SemiBold.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, size: 18.r, color: AppColors.brandNavy),
                ),
              ],
            ),
            hSpace(6),
            Text(value, style: AppTextStyles.font24Bold),
            hSpace(4),
            if (progress != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6.h,
                  backgroundColor: AppColors.pageBackground,
                  color: AppColors.pitchGreen,
                ),
              )
            else
              Text(
                hint ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font11Regular.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
