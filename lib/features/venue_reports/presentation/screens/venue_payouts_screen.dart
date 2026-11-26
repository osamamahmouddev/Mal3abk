import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_report_models.dart';
import '../../domain/repos/venue_reports_repo.dart';
import '../cubit/venue_reports_cubit.dart';

/// What the platform owes the venue, what it paid and the bookings behind
/// it, like the web "your payouts" page.
class VenuePayoutsScreen extends StatelessWidget {
  const VenuePayoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    String t(String key) => 'venue.payouts.$key'.tr(context: context);
    return BlocProvider<VenuePayoutsCubit>(
      create: (_) => VenuePayoutsCubit(
        venueReportsRepo: sl<VenueReportsRepo>(),
        venueId: session.venue.id,
      )..load(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(title: t('title')),
        body: BlocBuilder<VenuePayoutsCubit, ApiResult<VenuePayoutStatementModel>?>(
          builder: (context, result) {
            final cubit = context.read<VenuePayoutsCubit>();
            if (result == null) {
              return const ShimmerListSkeletonWidget(itemHeight: 80);
            }
            if (result case ApiFailure(:final failure)) {
              return Padding(
                padding: EdgeInsets.all(16.r),
                child: AlertBannerWidget(
                  type: AlertBannerType.error,
                  message: failure.message.tr(context: context),
                  actionText: 'common.retry'.tr(context: context),
                  onActionTap: cubit.load,
                ),
              );
            }
            final s = (result as Success<VenuePayoutStatementModel>).data;
            final b = s.balance;
            String m(num v) => VenueFormat.money(context, v, b.currency);
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
                  hSpace(12),
                  LayoutBuilder(
                    builder: (context, c) {
                      final w = (c.maxWidth - 10.w) / 2;
                      return Wrap(
                        spacing: 10.w,
                        runSpacing: 10.w,
                        children: [
                          for (final (label, value, hint) in [
                            (
                              t('balance'),
                              m(b.balance),
                              b.balance > 0
                                  ? t('balance_soon')
                                  : t('balance_settled'),
                            ),
                            (
                              t('deposits'),
                              m(b.depositsReceived),
                              'venue.payouts.bookings_count'.tr(
                                context: context,
                                args: [
                                  VenueFormat.number(
                                    context,
                                    b.settledBookings,
                                  ),
                                ],
                              ),
                            ),
                            (t('commission'), m(b.commission), ''),
                            (t('paid_out'), m(b.paidOut), ''),
                          ])
                            SizedBox(
                              width: w,
                              child: CustomCardWidget(
                                padding: EdgeInsets.all(12.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      label,
                                      style: AppTextStyles.font12SemiBold
                                          .copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                    hSpace(4),
                                    Text(
                                      value,
                                      style: AppTextStyles.font18Bold,
                                    ),
                                    if (hint.isNotEmpty)
                                      Text(
                                        hint,
                                        style: AppTextStyles.font11Regular
                                            .copyWith(
                                              color: AppColors.textMuted,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  hSpace(12),
                  VenueSectionCardWidget(
                    title: t('transfers_title'),
                    child: s.payouts.isEmpty
                        ? VenueEmptyLineWidget(
                            icon: Icons.account_balance_wallet_outlined,
                            text: t('no_transfers'),
                          )
                        : Column(
                            children: [
                              for (final p in s.payouts)
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    m(p.amount),
                                    style: AppTextStyles.font14Bold,
                                  ),
                                  subtitle: Text(
                                    '${'venue.payouts.method.${p.method}'.tr(context: context)} · ${'venue.payouts.reference'.tr(context: context, args: [p.reference])}',
                                  ),
                                  trailing: Text(
                                    VenueFormat.dateTime(context, p.paidAtUtc),
                                    style: AppTextStyles.font11Regular,
                                  ),
                                ),
                            ],
                          ),
                  ),
                  hSpace(12),
                  VenueSectionCardWidget(
                    title: t('bookings_title'),
                    child: s.bookings.isEmpty
                        ? VenueEmptyLineWidget(
                            icon: Icons.receipt_long_outlined,
                            text: t('no_bookings'),
                          )
                        : Column(
                            children: [
                              for (final line in s.bookings)
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    '${line.reference} · ${VenueFormat.dateTime(context, line.startUtc)}',
                                    style: AppTextStyles.font13SemiBold,
                                  ),
                                  subtitle: Text(
                                    [
                                      'venue.payouts.line'.tr(
                                        context: context,
                                        args: [
                                          m(line.depositReceived),
                                          m(line.commission),
                                        ],
                                      ),
                                      if (line.refunded > 0)
                                        'venue.payouts.refunded'.tr(
                                          context: context,
                                          args: [m(line.refunded)],
                                        ),
                                      'venue.payouts.status.${line.status}'.tr(
                                        context: context,
                                      ),
                                    ].join(' · '),
                                  ),
                                  trailing: Text(
                                    m(line.venueShare),
                                    style: AppTextStyles.font14Bold.copyWith(
                                      color: AppColors.successGreen,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
