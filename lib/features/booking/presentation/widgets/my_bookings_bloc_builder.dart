import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/booking_card_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../data/models/player_booking_summary_model.dart';
import '../cubit/my_bookings_cubit.dart';
import '../cubit/my_bookings_state.dart';
import 'booking_status_style.dart';

class MyBookingsBlocBuilder extends StatelessWidget {
  const MyBookingsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyBookingsCubit>();
    final lang = context.locale.languageCode;

    Future<void> open(String route, String bookingId) async {
      await Navigator.of(context).pushNamed(route, arguments: bookingId);
      final current = cubit.state;
      if (current is MyBookingsSuccess) await cubit.load(current.tab);
    }

    Widget card(PlayerBookingSummaryModel booking, int index) {
      final canUpload = booking.allowedActions.canUploadProof;
      return FadeSlideInWidget(
        index: index,
        child: BookingCardWidget(
          venueName: booking.venueName ?? '',
          pitchName: booking.pitchName ?? '',
          dateTime:
              '${CairoTime.dayAndTime(booking.startAt, lang)} – ${CairoTime.time(booking.endAt, lang)}',
          bookingCode: booking.reference,
          status: BookingStatusStyle.tone(booking.status),
          statusText: BookingStatusStyle.labelKey(
            booking.status,
          ).tr(context: context),
          depositRowText: 'booking.deposit_receipt'.tr(context: context),
          depositAmount: 'common.price_egp'.tr(
            context: context,
            args: [booking.depositAmount.round().toLocalizedDigits(lang)],
          ),
          primaryActionText: canUpload
              ? 'booking.upload.cta'.tr(context: context)
              : null,
          onPrimaryAction: canUpload
              ? () => open(AppRoutes.uploadProof, booking.id)
              : null,
          secondaryActionText: 'booking.list.details'.tr(context: context),
          onSecondaryAction: () => open(AppRoutes.bookingDetails, booking.id),
          onTap: () => open(AppRoutes.bookingDetails, booking.id),
        ),
      );
    }

    return BlocBuilder<MyBookingsCubit, MyBookingsState>(
      builder: (context, state) {
        return switch (state) {
          MyBookingsSuccess(:final items, :final tab) when items.isEmpty =>
            CustomStateWidget(
              icon: const Icon(Icons.event_note_rounded, size: 48),
              title: 'booking.list.empty_${tab.name}'.tr(context: context),
              description: 'booking.list.empty_desc'.tr(context: context),
            ),
          MyBookingsSuccess(:final items, :final hasMore, :final tab) =>
            RefreshIndicator.adaptive(
              onRefresh: () => cubit.load(tab),
              child: NotificationListener<ScrollNotification>(
                onNotification: (scroll) {
                  if (hasMore && scroll.metrics.extentAfter < 300) {
                    cubit.loadMore();
                  }
                  return false;
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: EdgeInsets.all(16.r),
                  itemCount: items.length + (hasMore ? 1 : 0),
                  separatorBuilder: (_, _) => hSpace(12),
                  itemBuilder: (context, index) => index == items.length
                      ? const ShimmerListSkeletonWidget(
                          itemHeight: 140,
                          itemCount: 1,
                          padding: EdgeInsets.zero,
                        )
                      : card(items[index], index),
                ),
              ),
            ),
          MyBookingsError(:final message, :final tab) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () => cubit.load(tab),
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 160, itemCount: 3),
        };
      },
    );
  }
}
