import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_search_field_widget.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_shell/data/models/my_permissions_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/venue_bookings_query.dart';
import '../cubit/venue_bookings_cubit.dart';
import '../cubit/venue_bookings_state.dart';
import 'venue_booking_card_widget.dart';
import 'venue_bookings_filters_widget.dart';

class VenueBookingsListWidget extends StatelessWidget {
  const VenueBookingsListWidget({super.key});

  static const _tabs = VenueBookingsTab.values;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    final cubit = context.read<VenueBookingsCubit>();
    String t(String key) => 'venue.bookings.$key'.tr(context: context);

    return BlocBuilder<VenueBookingsCubit, VenueBookingsState>(
      builder: (context, state) {
        final query = state.query;
        final counts = state is VenueBookingsSuccess
            ? state.counts
            : const <VenueBookingsTab, int>{};
        return Column(
          children: [
            Container(
              color: AppColors.white,
              child: CustomTabBarWidget(
                tabs: [for (final tab in _tabs) t('tab_${tab.name}')],
                selectedIndex: _tabs.indexOf(query.tab),
                badgeCounts: {
                  for (final (i, tab) in _tabs.indexed)
                    if (counts[tab] != null) i: counts[tab]!,
                },
                onTabSelected: (i) =>
                    cubit.setQuery(query.copyWith(tab: _tabs[i])),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
              child: CustomSearchFieldWidget(
                hintText: t('search_hint'),
                onChanged: cubit.setSearch,
              ),
            ),
            hSpace(10),
            VenueBookingsFiltersWidget(venue: session.venue, query: query),
            hSpace(8),
            Expanded(
              child: RefreshIndicator(
                onRefresh: cubit.refresh,
                child: switch (state) {
                  VenueBookingsLoading() => const ShimmerListSkeletonWidget(
                    itemHeight: 120,
                    itemCount: 5,
                  ),
                  VenueBookingsError(:final message) => ListView(
                    padding: EdgeInsets.all(16.r),
                    children: [
                      AlertBannerWidget(
                        type: AlertBannerType.error,
                        message: message.tr(context: context),
                        actionText: 'common.retry'.tr(context: context),
                        onActionTap: cubit.refresh,
                      ),
                    ],
                  ),
                  VenueBookingsSuccess(:final items) when items.isEmpty =>
                    ListView(
                      padding: EdgeInsets.all(24.r),
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 48.r,
                          color: AppColors.textMuted,
                        ),
                        hSpace(8),
                        Text(
                          t('empty'),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        if (query.hasFilters)
                          TextButton(
                            onPressed: () =>
                                cubit.setQuery(const VenueBookingsQuery()),
                            child: Text(t('clear_filters')),
                          ),
                      ],
                    ),
                  VenueBookingsSuccess() =>
                    NotificationListener<ScrollNotification>(
                      onNotification: (n) {
                        if (n.metrics.extentAfter < 400) cubit.loadMore();
                        return false;
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 120.h),
                        itemCount: state.items.length + 1,
                        separatorBuilder: (_, _) => hSpace(10),
                        itemBuilder: (context, i) {
                          if (i == state.items.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Column(
                                children: [
                                  if (state.isLoadingMore)
                                    const CircularProgressIndicator(),
                                  Text(
                                    'venue.bookings.showing'.tr(
                                      context: context,
                                      args: [
                                        VenueFormat.number(
                                          context,
                                          state.items.length,
                                        ),
                                        VenueFormat.number(
                                          context,
                                          state.totalCount,
                                        ),
                                      ],
                                    ),
                                    style: AppTextStyles.font12Regular.copyWith(
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          final b = state.items[i];
                          return VenueBookingCardWidget(
                            booking: b,
                            pitchName:
                                session.venue.pitches
                                    .where((p) => p.id == b.pitchId)
                                    .firstOrNull
                                    ?.name ??
                                t('pitch_fallback'),
                            canConfirm: session.can(
                              VenuePermissions.bookingsApprove,
                            ),
                            isConfirming: state.actionBookingId == b.id,
                            onConfirm: () async {
                              final error = await cubit.confirmManual(b.id);
                              if (!context.mounted) return;
                              if (error == null) {
                                AppTopSnackBar.showSuccess(
                                  context,
                                  t('confirmed_toast'),
                                );
                              } else {
                                AppTopSnackBar.showError(
                                  context,
                                  error.tr(context: context),
                                );
                              }
                            },
                            onDetails: () async {
                              final changed = await context.pushNamed<bool>(
                                AppRoutes.venueBookingDetail,
                                arguments: VenueBookingDetailArgs(
                                  venueId: session.venue.id,
                                  bookingId: b.id,
                                  canApprove: session.can(
                                    VenuePermissions.bookingsApprove,
                                  ),
                                ),
                              );
                              if (changed == true) await cubit.refresh();
                            },
                          );
                        },
                      ),
                    ),
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

/// What the booking details screen needs.
class VenueBookingDetailArgs {
  const VenueBookingDetailArgs({
    required this.venueId,
    required this.bookingId,
    required this.canApprove,
  });

  final String venueId;
  final String bookingId;
  final bool canApprove;
}
