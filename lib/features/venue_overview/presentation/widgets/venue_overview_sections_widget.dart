import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_booking_row_widget.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_dashboard_model.dart';
import 'venue_finance_strip_widget.dart';
import 'venue_kpi_grid_widget.dart';
import 'venue_occupancy_card_widget.dart';
import 'venue_revenue_trend_widget.dart';

class VenueOverviewSectionsWidget extends StatelessWidget {
  const VenueOverviewSectionsWidget({
    required this.dashboard,
    required this.venue,
    required this.onOpenCalendar,
    required this.onOpenBookings,
    required this.onManualBooking,
    super.key,
  });

  final VenueDashboardModel dashboard;
  final VenueModel venue;
  final VoidCallback onOpenCalendar;
  final VoidCallback onOpenBookings;
  final VoidCallback onManualBooking;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.overview.$key'.tr(context: context);
    String pitchName(String id) =>
        venue.pitches.where((p) => p.id == id).firstOrNull?.name ??
        t('pitch_fallback');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        VenueKpiGridWidget(dashboard: dashboard),
        if (dashboard.todayRevenue != null &&
            dashboard.monthRevenue != null) ...[
          hSpace(16),
          VenueFinanceStripWidget(
            today: dashboard.todayRevenue!,
            month: dashboard.monthRevenue!,
          ),
        ],
        hSpace(16),
        VenueSectionCardWidget(
          title: t('today_bookings'),
          actionText: t('open_calendar'),
          onAction: onOpenCalendar,
          child: dashboard.timeline.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.event_available_rounded,
                      size: 40.r,
                      color: AppColors.textMuted,
                    ),
                    hSpace(8),
                    Text(
                      t('no_bookings_today'),
                      style: AppTextStyles.font14Bold,
                      textAlign: TextAlign.center,
                    ),
                    hSpace(4),
                    Text(
                      t('no_bookings_today_hint'),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    hSpace(12),
                    CustomButton(
                      text: t('manual_booking_cta'),
                      type: CustomButtonType.outline,
                      height: 42.h,
                      borderRadius: 12,
                      onTap: onManualBooking,
                    ),
                  ],
                )
              : Column(
                  children: [
                    for (final (i, b) in dashboard.timeline.indexed) ...[
                      if (i > 0) const Divider(height: 1),
                      VenueBookingRowWidget(
                        timeLabel: VenueFormat.time(context, b.startUtc),
                        pitchName: pitchName(b.pitchId),
                        customerName: b.customerName,
                        status: b.status,
                        isManual: b.isManual,
                        totalPrice: b.totalPrice,
                        depositAmount: b.depositAmount,
                        depositState: b.depositState,
                        currency: b.currency,
                      ),
                    ],
                  ],
                ),
        ),
        hSpace(16),
        VenueSectionCardWidget(
          title: t('proofs_title'),
          subtitle: t('proofs_subtitle'),
          actionText: t('bookings_link'),
          onAction: onOpenBookings,
          child: dashboard.proofsAwaitingReview.isEmpty
              ? VenueEmptyLineWidget(
                  icon: Icons.receipt_long_outlined,
                  text: t('no_proofs'),
                )
              : Column(
                  children: [
                    for (final p in dashboard.proofsAwaitingReview.take(4))
                      _LineRow(
                        icon: Icons.receipt_long_outlined,
                        title:
                            '${p.customerName.isEmpty ? t('player_fallback') : p.customerName} · ${VenueFormat.money(context, p.depositAmount, p.currency)}',
                        subtitle:
                            '${pitchName(p.pitchId)} · ${VenueFormat.dateTime(context, p.startUtc)}',
                        trailing: AppBadgeWidget(
                          text: t('in_review'),
                          type: AppBadgeType.warning,
                        ),
                      ),
                  ],
                ),
        ),
        hSpace(16),
        VenueOccupancyCardWidget(
          thisWeek: dashboard.occupancyThisWeek,
          lastWeek: dashboard.occupancyLastWeek,
        ),
        hSpace(16),
        VenueSectionCardWidget(
          title: t('upcoming_title'),
          child: dashboard.upcoming.isEmpty
              ? VenueEmptyLineWidget(
                  icon: Icons.calendar_month_outlined,
                  text: t('no_upcoming'),
                )
              : Column(
                  children: [
                    for (final b in dashboard.upcoming)
                      _LineRow(
                        title: VenueFormat.dateTime(context, b.startUtc),
                        subtitle:
                            '${b.customerName.isEmpty ? '—' : b.customerName} · ${pitchName(b.pitchId)}',
                        trailing: AppBadgeWidget(
                          text: VenueFormat.statusLabel(
                            context,
                            b.status,
                            isManual: b.isManual,
                            deposit: b.depositAmount,
                          ),
                          type: VenueFormat.statusTone(
                            b.status,
                            isManual: b.isManual,
                            deposit: b.depositAmount,
                          ),
                        ),
                      ),
                  ],
                ),
        ),
        if (dashboard.revenueTrend != null) ...[
          hSpace(16),
          VenueRevenueTrendWidget(points: dashboard.revenueTrend!),
        ],
        hSpace(16),
        VenueSectionCardWidget(
          title: t('activity_title'),
          child: dashboard.recentActivity.isEmpty
              ? VenueEmptyLineWidget(
                  icon: Icons.timeline_rounded,
                  text: t('no_activity'),
                )
              : Column(
                  children: [
                    for (final a in dashboard.recentActivity)
                      _LineRow(
                        icon: Icons.circle,
                        iconSize: 8,
                        title: [
                          '${'venue.activity.${a.toStatus}'.tr(context: context)} — ${a.reference}',
                          if (a.reason?.isNotEmpty ?? false) a.reason!,
                        ].join(' · '),
                        subtitle: VenueFormat.dateTime(context, a.changedAtUtc),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _LineRow extends StatelessWidget {
  const _LineRow({
    required this.title,
    required this.subtitle,
    this.icon,
    this.iconSize = 18,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData? icon;
  final double iconSize;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: iconSize.r, color: AppColors.textMuted),
            SizedBox(width: 10.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.font13SemiBold),
                hSpace(2),
                Text(
                  subtitle,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[SizedBox(width: 8.w), trailing!],
        ],
      ),
    );
  }
}
