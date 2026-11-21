import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../data/models/booking_status.dart';
import '../cubit/booking_details_cubit.dart';
import '../cubit/booking_details_state.dart';
import 'booking_details_skeleton_widget.dart';
import 'booking_pass_actions_widget.dart';
import 'booking_pass_hero_widget.dart';
import 'booking_pass_payment_card_widget.dart';
import 'booking_pass_qr_card_widget.dart';
import 'booking_pass_timeline_widget.dart';
import '../../../../core/animations/ball_refresh_indicator.dart';

class BookingDetailsBlocBuilder extends StatelessWidget {
  const BookingDetailsBlocBuilder({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingDetailsCubit>();
    return BlocBuilder<BookingDetailsCubit, BookingDetailsState>(
      builder: (context, state) => switch (state) {
        BookingDetailsSuccess(:final booking) => BallRefreshIndicator(
          onRefresh: () => cubit.load(bookingId),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.all(16.r),
            children: [
              BookingPassHeroWidget(booking: booking),
              hSpace(12),
              if (booking.status.hasPass) ...[
                BookingPassQrCardWidget(reference: booking.reference),
                hSpace(12),
              ] else if (booking.status.isAwaitingVenue) ...[
                AlertBannerWidget(
                  message: 'booking.pass.awaiting_venue'.tr(context: context),
                ),
                hSpace(12),
              ] else if (booking.status == BookingStatus.rejected) ...[
                AlertBannerWidget(
                  type: AlertBannerType.error,
                  message: 'booking.pass.proof_rejected'.tr(context: context),
                ),
                hSpace(12),
              ],
              BookingPassActionsWidget(booking: booking),
              hSpace(12),
              BookingPassPaymentCardWidget(booking: booking),
              if (booking.statusHistory.isNotEmpty) ...[
                hSpace(12),
                BookingPassTimelineWidget(booking: booking),
              ],
            ],
          ),
        ),
        BookingDetailsError(:final message) => CustomStateWidget(
          title: message.tr(context: context),
          description: '',
          actionText: 'common.retry'.tr(context: context),
          onActionTap: () => cubit.load(bookingId),
        ),
        _ => const BookingDetailsSkeletonWidget(),
      },
    );
  }
}
