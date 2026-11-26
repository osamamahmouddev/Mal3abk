import 'dart:math' as math;
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart' as intl;
import 'package:share_plus/share_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../domain/repos/venue_reports_repo.dart';
import '../cubit/venue_reports_cubit.dart';

/// Bookings, revenue, occupancy per pitch, peak hours and status split for
/// a period, with the bookings CSV, like the web reports page.
class VenueReportsScreen extends StatelessWidget {
  const VenueReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    String t(String key) => 'venue.reports.$key'.tr(context: context);
    return BlocProvider<VenueReportsCubit>(
      create: (_) => VenueReportsCubit(
        venueReportsRepo: sl<VenueReportsRepo>(),
        venueId: session.venue.id,
      )..load(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<VenueReportsCubit>();
          return Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(
              title: t('title'),
              actions: [
                BlocBuilder<VenueReportsCubit, VenueReportsState>(
                  buildWhen: (a, b) => a.exporting != b.exporting,
                  builder: (context, state) => IconButton(
                    tooltip: t('export'),
                    onPressed: state.exporting
                        ? null
                        : () async {
                            final (bytes, name, error) = await cubit
                                .exportCsv();
                            if (!context.mounted) return;
                            if (bytes == null) {
                              AppTopSnackBar.showError(
                                context,
                                (error ?? 'common.unexpected_error').tr(
                                  context: context,
                                ),
                              );
                              return;
                            }
                            await SharePlus.instance.share(
                              ShareParams(
                                files: [
                                  XFile.fromData(
                                    Uint8List.fromList(bytes),
                                    mimeType: 'text/csv',
                                    name: name,
                                  ),
                                ],
                                fileNameOverrides: [name],
                              ),
                            );
                          },
                    icon: state.exporting
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.ios_share_rounded),
                  ),
                ),
              ],
            ),
            body: _Body(venue: session.venue),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.venue});

  final VenueModel venue;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueReportsCubit>();
    final lang = context.locale.languageCode;
    String t(String key) => 'venue.reports.$key'.tr(context: context);
    String m(num v, String c) => VenueFormat.money(context, v, c);
    String digits(String s) => lang == 'ar' ? s.toArabicDigits() : s;

    String period(String start, int groupBy) {
      final d = DateTime.parse(start);
      return switch (groupBy) {
        2 => intl.DateFormat('MMMM', lang).format(d),
        1 => 'venue.reports.week_of'.tr(
          context: context,
          args: [digits(intl.DateFormat('d MMM', lang).format(d))],
        ),
        _ => digits(intl.DateFormat('EEE d', lang).format(d)),
      };
    }

    Future<void> pick(bool from) async {
      final s = cubit.state;
      final picked = await showDatePicker(
        context: context,
        initialDate: from ? s.customFrom : s.customTo,
        firstDate: DateTime(2024),
        lastDate: DateTime(s.customTo.year + 1, 12, 31),
      );
      if (picked == null) return;
      final date = DateTime(picked.year, picked.month, picked.day);
      from ? cubit.setCustom(from: date) : cubit.setCustom(to: date);
    }

    return BlocBuilder<VenueReportsCubit, VenueReportsState>(
      builder: (context, state) {
        final r = state.report;
        return RefreshIndicator(
          onRefresh: cubit.load,
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
            children: [
              Text(
                t('intro'),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(8),
              Wrap(
                spacing: 8.w,
                children: [
                  for (final p in ReportPreset.values)
                    ChoiceChip(
                      label: Text(t('preset_${p.name}')),
                      selected: state.preset == p,
                      onSelected: (_) => cubit.setPreset(p),
                    ),
                ],
              ),
              if (state.preset == ReportPreset.custom)
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => pick(true),
                        child: Text(
                          '${t('from')} ${VenueFormat.day(context, state.customFrom)}',
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => pick(false),
                        child: Text(
                          '${t('to')} ${VenueFormat.day(context, state.customTo)}',
                        ),
                      ),
                    ),
                  ],
                ),
              DropdownButton<String?>(
                isExpanded: true,
                value: state.pitchId,
                items: [
                  DropdownMenuItem<String?>(
                    value: null,
                    child: Text(t('all_pitches')),
                  ),
                  for (final p in venue.pitches)
                    DropdownMenuItem<String?>(value: p.id, child: Text(p.name)),
                ],
                onChanged: cubit.setPitch,
              ),
              hSpace(8),
              if (state.error case final e?)
                AlertBannerWidget(
                  type: AlertBannerType.error,
                  message: e.tr(context: context),
                  actionText: 'common.retry'.tr(context: context),
                  onActionTap: cubit.load,
                ),
              if (state.loading && r == null)
                const ShimmerListSkeletonWidget(
                  itemHeight: 90,
                  itemCount: 4,
                  padding: EdgeInsets.zero,
                ),
              if (r != null) ...[
                if (state.loading) const LinearProgressIndicator(minHeight: 2),
                VenueSectionCardWidget(
                  title: t('money_title'),
                  child: Column(
                    children: [
                      for (final (label, value, hint) in [
                        (t('booked'), r.revenue.booked, t('booked_hint')),
                        (
                          t('deposits'),
                          r.revenue.depositsReceived,
                          t('deposits_hint'),
                        ),
                        (
                          t('outstanding'),
                          r.revenue.outstanding,
                          t('outstanding_hint'),
                        ),
                        (
                          t('recognized'),
                          r.revenue.recognized,
                          t('recognized_hint'),
                        ),
                        (
                          t('commission'),
                          r.revenue.platformCommission,
                          t('commission_hint'),
                        ),
                        (t('net'), r.revenue.venueNetRevenue, t('net_hint')),
                      ])
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            label,
                            style: AppTextStyles.font13SemiBold,
                          ),
                          subtitle: Text(hint),
                          trailing: Text(
                            m(value, r.revenue.currency),
                            style: AppTextStyles.font14Bold,
                          ),
                        ),
                      if (r.revenue.pending > 0)
                        Text(
                          'venue.reports.pending_note'.tr(
                            context: context,
                            args: [m(r.revenue.pending, r.revenue.currency)],
                          ),
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.goldText,
                          ),
                        ),
                    ],
                  ),
                ),
                hSpace(12),
                VenueSectionCardWidget(
                  title: t('trend_title'),
                  trailing: Text(
                    'venue.reports.bookings_count'.tr(
                      context: context,
                      args: [VenueFormat.number(context, r.totalBookings)],
                    ),
                    style: AppTextStyles.font12Regular,
                  ),
                  child: _Bars(
                    items: [
                      for (final b in r.revenueSeries)
                        (
                          period(b.periodStart, r.groupBy),
                          b.booked,
                          b.recognized,
                        ),
                    ],
                  ),
                ),
                hSpace(12),
                VenueSectionCardWidget(
                  title: t('utilization_title'),
                  child: Column(
                    children: [
                      if (r.pitchUtilization.isEmpty)
                        VenueEmptyLineWidget(
                          icon: Icons.stadium_outlined,
                          text: t('no_pitches'),
                        ),
                      for (final p in r.pitchUtilization)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90.w,
                                child: Text(
                                  p.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: (p.percent / 100)
                                      .clamp(0, 1)
                                      .toDouble(),
                                  minHeight: 8.h,
                                  backgroundColor: AppColors.pageBackground,
                                  color: AppColors.pitchGreen,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(VenueFormat.percent(context, p.percent)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                hSpace(12),
                VenueSectionCardWidget(
                  title: t('peak_title'),
                  child: Builder(
                    builder: (context) {
                      final hours = [...r.peakHours]
                        ..sort((a, b) => b.bookings.compareTo(a.bookings));
                      if (hours.isEmpty) {
                        return VenueEmptyLineWidget(
                          icon: Icons.schedule_rounded,
                          text: t('no_bookings'),
                        );
                      }
                      return Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          for (final h in hours.take(8))
                            Chip(
                              label: Text(
                                '${intl.DateFormat('EEE', lang).format(DateTime(2026, 1, 4 + h.dayOfWeek))} ${digits(intl.DateFormat('h a', lang).format(DateTime(2000, 1, 1, h.hour)))} · ${VenueFormat.number(context, h.bookings)}',
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                hSpace(12),
                VenueSectionCardWidget(
                  title: t('status_title'),
                  child: r.statusDistribution.isEmpty
                      ? VenueEmptyLineWidget(
                          icon: Icons.pie_chart_outline_rounded,
                          text: t('no_bookings'),
                        )
                      : Column(
                          children: [
                            for (final e in r.statusDistribution.entries)
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      VenueBookingStatus.keyOfName(e.key) ==
                                              null
                                          ? e.key
                                          : 'venue.status.${VenueBookingStatus.keyOfName(e.key)}'
                                                .tr(context: context),
                                    ),
                                  ),
                                  Text(VenueFormat.number(context, e.value)),
                                ],
                              ),
                          ],
                        ),
                ),
                hSpace(12),
                VenueSectionCardWidget(
                  title: t('periods_title'),
                  child: Column(
                    children: [
                      for (final b in r.bookings)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(period(b.periodStart, r.groupBy)),
                              ),
                              Text(
                                'venue.reports.period_line'.tr(
                                  context: context,
                                  args: [
                                    VenueFormat.number(context, b.total),
                                    VenueFormat.number(
                                      context,
                                      b.confirmed + b.completed,
                                    ),
                                    VenueFormat.number(context, b.cancelled),
                                    VenueFormat.number(context, b.noShows),
                                  ],
                                ),
                                style: AppTextStyles.font12Regular,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _Bars extends StatelessWidget {
  const _Bars({required this.items});

  /// (label, booked, recognized).
  final List<(String, double, double)> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final max = items.fold<double>(
      1,
      (m, i) => math.max(m, math.max(i.$2, i.$3)),
    );
    return SizedBox(
      height: 140.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final (label, booked, recognized) in items)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 10.w,
                          height: math.max(2, booked / max * 100.h),
                          color: const Color(0xFFC9D3E6),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          width: 10.w,
                          height: math.max(2, recognized / max * 100.h),
                          color: AppColors.pitchGreenLight,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(label, style: AppTextStyles.font10Regular),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
