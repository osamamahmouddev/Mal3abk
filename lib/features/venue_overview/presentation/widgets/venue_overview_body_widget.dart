import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/screens/venue_shell_screen.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../cubit/venue_overview_cubit.dart';
import '../cubit/venue_overview_state.dart';
import 'venue_approval_banner_widget.dart';
import 'venue_overview_sections_widget.dart';
import 'venue_quick_actions_widget.dart';

class VenueOverviewBodyWidget extends StatelessWidget {
  const VenueOverviewBodyWidget({required this.onOpenTab, super.key});

  final ValueChanged<int> onOpenTab;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    final venue = session.venue;

    Future<void> reload() => context.read<VenueOverviewCubit>().load(
      venue.id,
      isApproved: venue.isApproved,
    );

    Future<void> openManualBooking() async {
      final created = await context.pushNamed<bool>(
        AppRoutes.venueManualBooking,
        arguments: venue,
      );
      if (created == true) await reload();
    }

    return RefreshIndicator(
      onRefresh: reload,
      child: BlocBuilder<VenueOverviewCubit, VenueOverviewState>(
        builder: (context, state) {
          final adminMessage = state is VenueOverviewSuccess
              ? state.adminMessage
              : null;
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 120.h),
            children: [
              if (venue.approvalStatus != 'Approved') ...[
                VenueApprovalBannerWidget(
                  status: venue.approvalStatus,
                  adminMessage: adminMessage,
                ),
                hSpace(16),
              ],
              Text(
                '${VenueFormat.day(context, CairoTime.today())} · ${'venue.overview.active_pitches'.tr(context: context, args: [VenueFormat.number(context, venue.activePitches.length)])}',
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(12),
              VenueQuickActionsWidget(
                onBlockSlot: () => onOpenTab(VenueShellScreen.calendarTab),
                onManualBooking: openManualBooking,
              ),
              hSpace(16),
              switch (state) {
                VenueOverviewLoading() => const ShimmerListSkeletonWidget(
                  itemHeight: 96,
                  itemCount: 4,
                  padding: EdgeInsets.zero,
                ),
                VenueOverviewError(:final message) => AlertBannerWidget(
                  type: AlertBannerType.error,
                  message: 'venue.overview.load_error'.tr(
                    context: context,
                    args: [message.tr(context: context)],
                  ),
                  actionText: 'common.retry'.tr(context: context),
                  onActionTap: reload,
                ),
                VenueOverviewSuccess(:final dashboard) =>
                  VenueOverviewSectionsWidget(
                    dashboard: dashboard,
                    venue: venue,
                    onOpenCalendar: () =>
                        onOpenTab(VenueShellScreen.calendarTab),
                    onOpenBookings: () =>
                        onOpenTab(VenueShellScreen.bookingsTab),
                    onManualBooking: openManualBooking,
                  ),
              },
            ],
          );
        },
      ),
    );
  }
}
