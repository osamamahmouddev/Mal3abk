import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/app/app_spaces.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../venue_shell/data/models/my_permissions_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../calendar_layout.dart';
import '../cubit/venue_calendar_cubit.dart';
import '../cubit/venue_calendar_state.dart';
import '../screens/venue_manual_booking_screen.dart';
import 'calendar_bulk_bar_widget.dart';
import 'calendar_empty_slot_sheet_widget.dart';
import 'calendar_legend_widget.dart';
import 'calendar_month_grid_widget.dart';
import 'calendar_slot_sheet_widget.dart';
import 'calendar_time_grid_widget.dart';
import 'calendar_toolbar_widget.dart';

class VenueCalendarBodyWidget extends StatelessWidget {
  const VenueCalendarBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    final venue = session.venue;
    final cubit = context.read<VenueCalendarCubit>();
    final lang = context.locale.languageCode;

    return BlocBuilder<VenueCalendarCubit, VenueCalendarState>(
      builder: (context, state) {
        final (first, last) = CalendarLayout.visibleHours(
          state.schedules,
          state.date,
          state.view,
          state.slots,
        );
        final weekStart = VenueCalendarCubit.weekStart(state.date);
        final columns = switch (state.view) {
          // Existing bookings stay visible even if their pitch was paused.
          VenueCalendarView.day => [
            for (final p in venue.pitches)
              CalendarColumn(
                key: p.id,
                label: p.name,
                date: state.date,
                pitchId: p.id,
              ),
          ],
          VenueCalendarView.week => [
            if (state.weekPitchId != null)
              for (var i = 0; i < 7; i++)
                if (DateTime(weekStart.year, weekStart.month, weekStart.day + i)
                    case final day)
                  CalendarColumn(
                    key: '$i',
                    label:
                        '${intl.DateFormat('EEE', lang).format(day)} ${VenueFormat.number(context, day.day)}',
                    date: day,
                    pitchId: state.weekPitchId!,
                  ),
          ],
          VenueCalendarView.month => const <CalendarColumn>[],
        };

        void showMessage(String? error, String success) {
          if (!context.mounted) return;
          if (error == null) {
            AppTopSnackBar.showSuccess(context, success);
          } else {
            AppTopSnackBar.showError(context, error.tr(context: context));
          }
        }

        return Column(
          children: [
            CalendarToolbarWidget(venue: venue, state: state),
            const CalendarLegendWidget(),
            if (state.error != null)
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
                child: AlertBannerWidget(
                  type: AlertBannerType.error,
                  message: state.error!.tr(context: context),
                  actionText: 'common.retry'.tr(context: context),
                  onActionTap: cubit.load,
                ),
              ),
            if (state.isLoading) const LinearProgressIndicator(minHeight: 2),
            Expanded(
              child: state.view == VenueCalendarView.month
                  ? CalendarMonthGridWidget(
                      date: state.date,
                      slots: state.slots,
                      onOpenDay: cubit.openDay,
                    )
                  : CalendarTimeGridWidget(
                      columns: columns,
                      slots: state.slots,
                      firstHour: first,
                      lastHour: last,
                      picking: state.picking,
                      pickedHours: state.pickedHours,
                      pickedTaken: state.pickedTaken,
                      onPickAll: (column) => cubit.toggleAll(
                        CalendarLayout.freeHours(column, [
                          for (var h = first; h < last; h++) h,
                        ], state.slots),
                      ),
                      onEmpty: (column, hour) async {
                        if (state.picking) {
                          cubit.toggleHour(CalendarLayout.hourOf(column, hour));
                          return;
                        }
                        final choice = await CalendarEmptySlotSheetWidget.show(
                          context,
                          start: CalendarLayout.hourOf(column, hour).start,
                          canBook: session.can(
                            VenuePermissions.bookingsApprove,
                          ),
                          canBlock: session.can(
                            VenuePermissions.blockedSlotsManage,
                          ),
                        );
                        if (!context.mounted || choice == null) return;
                        if (choice.book) {
                          final created = await context.pushNamed<bool>(
                            AppRoutes.venueManualBooking,
                            arguments: VenueManualBookingArgs(
                              venue: venue,
                              pitchId: column.pitchId,
                              date: column.date,
                              startMinutes: hour * 60,
                            ),
                          );
                          if (created == true) await cubit.load(silent: true);
                        } else {
                          final success = 'venue.calendar.blocked_toast'.tr(
                            context: context,
                          );
                          final result = await cubit.blockSlot(
                            pitchId: column.pitchId,
                            startUtc: CalendarLayout.hourOf(column, hour).start,
                            hours: choice.hours,
                            reason: choice.reason,
                          );
                          showMessage(
                            result.when(
                              success: (_) => null,
                              failure: (f) => f.message,
                            ),
                            success,
                          );
                        }
                      },
                      onSlot: (slot) async {
                        if (state.picking) {
                          if (!cubit.toggleTaken(slot)) {
                            AppTopSnackBar.showInfo(
                              context,
                              'venue.calendar.app_booking_hint'.tr(
                                context: context,
                              ),
                            );
                          }
                          return;
                        }
                        await CalendarSlotSheetWidget.show(
                          context,
                          slot: slot,
                          pitchName:
                              venue.pitches
                                  .where((p) => p.id == slot.pitchId)
                                  .firstOrNull
                                  ?.name ??
                              '',
                          canDecide: session.can(
                            VenuePermissions.bookingsApprove,
                          ),
                          canUnblock: session.can(
                            VenuePermissions.blockedSlotsManage,
                          ),
                          cubit: cubit,
                        );
                      },
                    ),
            ),
            if (state.picking && state.view != VenueCalendarView.month)
              CalendarBulkBarWidget(
                state: state,
                canUnblock: session.can(VenuePermissions.blockedSlotsManage),
              ),
            if (!state.picking) hSpace(96),
          ],
        );
      },
    );
  }
}
