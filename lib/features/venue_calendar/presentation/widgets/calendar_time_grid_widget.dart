import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/calendar_slot_model.dart';
import '../../data/models/manual_booking_request_body.dart';
import '../calendar_layout.dart';
import 'calendar_slot_style.dart';

/// Time grid: one column per pitch (day view) or per day (week view); taken
/// slots are placed by their real start and length.
class CalendarTimeGridWidget extends StatelessWidget {
  const CalendarTimeGridWidget({
    required this.columns,
    required this.slots,
    required this.firstHour,
    required this.lastHour,
    required this.picking,
    required this.pickedHours,
    required this.pickedTaken,
    required this.onEmpty,
    required this.onSlot,
    required this.onPickAll,
    super.key,
  });

  final List<CalendarColumn> columns;
  final List<CalendarSlotModel> slots;
  final int firstHour;
  final int lastHour;
  final bool picking;
  final Map<String, CalendarHour> pickedHours;
  final Map<String, bool> pickedTaken;
  final void Function(CalendarColumn column, int hour) onEmpty;
  final ValueChanged<CalendarSlotModel> onSlot;
  final ValueChanged<CalendarColumn> onPickAll;

  @override
  Widget build(BuildContext context) {
    if (columns.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Text(
            'venue.calendar.no_pitches'.tr(context: context),
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Regular,
          ),
        ),
      );
    }
    final rowHeight = 56.h;
    final hours = [for (var h = firstHour; h < lastHour; h++) h];
    final gridHeight = hours.length * rowHeight;
    final labelWidth = 58.w;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = math.max(
          112.w,
          (constraints.maxWidth - labelWidth) / columns.length,
        );
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: labelWidth,
                child: Column(
                  children: [
                    SizedBox(height: picking ? 64.h : 40.h),
                    for (final h in hours)
                      SizedBox(
                        height: rowHeight,
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: 6.w,
                              top: 2.h,
                            ),
                            child: Text(
                              _hourLabel(context, h),
                              style: AppTextStyles.font10Bold.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final column in columns)
                        SizedBox(
                          width: columnWidth,
                          child: Column(
                            children: [
                              _Header(
                                column: column,
                                picking: picking,
                                onPickAll: () => onPickAll(column),
                              ),
                              SizedBox(
                                height: gridHeight,
                                child: _ColumnBody(
                                  column: column,
                                  hours: hours,
                                  rowHeight: rowHeight,
                                  firstHour: firstHour,
                                  lastHour: lastHour,
                                  slots: slots,
                                  picking: picking,
                                  pickedHours: pickedHours,
                                  pickedTaken: pickedTaken,
                                  onEmpty: onEmpty,
                                  onSlot: onSlot,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// "٨ م", including late-night hours past midnight.
  static String _hourLabel(BuildContext context, int hour) {
    final h = hour % 24;
    final h12 = h % 12 == 0 ? 12 : h % 12;
    final period = h < 5 || h >= 17
        ? 'venue.calendar.period_night'
        : h < 12
        ? 'venue.calendar.period_morning'
        : 'venue.calendar.period_noon';
    final number = context.locale.languageCode == 'ar'
        ? '$h12'.toArabicDigits()
        : '$h12';
    return '$number ${period.tr(context: context)}';
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.column,
    required this.picking,
    required this.onPickAll,
  });

  final CalendarColumn column;
  final bool picking;
  final VoidCallback onPickAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: picking ? 64.h : 40.h,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.border),
          left: BorderSide(color: AppColors.borderCard),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            column.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font12Bold,
          ),
          if (picking)
            TextButton(
              onPressed: onPickAll,
              style: TextButton.styleFrom(
                minimumSize: Size(0, 28.h),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
              ),
              child: Text(
                'venue.calendar.whole_day'.tr(context: context),
                style: AppTextStyles.font11Bold.copyWith(
                  color: AppColors.brandRed,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ColumnBody extends StatelessWidget {
  const _ColumnBody({
    required this.column,
    required this.hours,
    required this.rowHeight,
    required this.firstHour,
    required this.lastHour,
    required this.slots,
    required this.picking,
    required this.pickedHours,
    required this.pickedTaken,
    required this.onEmpty,
    required this.onSlot,
  });

  final CalendarColumn column;
  final List<int> hours;
  final double rowHeight;
  final int firstHour;
  final int lastHour;
  final List<CalendarSlotModel> slots;
  final bool picking;
  final Map<String, CalendarHour> pickedHours;
  final Map<String, bool> pickedTaken;
  final void Function(CalendarColumn column, int hour) onEmpty;
  final ValueChanged<CalendarSlotModel> onSlot;

  @override
  Widget build(BuildContext context) {
    final mine = slots.where((s) {
      if (s.pitchId != column.pitchId) return false;
      final start = CalendarLayout.minutesFrom(column.date, s.start);
      return start >= firstHour * 60 - 60 && start < lastHour * 60;
    });
    return Stack(
      children: [
        for (final (i, h) in hours.indexed)
          Positioned(
            top: i * rowHeight,
            left: 0,
            right: 0,
            height: rowHeight,
            child: _EmptyCell(
              picked: pickedHours.containsKey(
                CalendarLayout.hourOf(column, h).key,
              ),
              label:
                  '${column.label} ${CalendarTimeGridWidget._hourLabel(context, h)}',
              onTap: () => onEmpty(column, h),
            ),
          ),
        for (final s in mine)
          Builder(
            builder: (context) {
              final start = math.max(
                CalendarLayout.minutesFrom(column.date, s.start),
                firstHour * 60.0,
              );
              final end = math.min(
                CalendarLayout.minutesFrom(column.date, s.end),
                lastHour * 60.0,
              );
              final kind = s.kind;
              final title = kind == CalendarSlotKind.blocked
                  ? ((s.reason?.isNotEmpty ?? false)
                        ? s.reason!
                        : CalendarSlotStyle.label(context, kind))
                  : ((s.customerName?.isNotEmpty ?? false)
                        ? s.customerName!
                        : s.isManual
                        ? 'venue.booking_row.manual'.tr(context: context)
                        : '—');
              final picked = pickedTaken.containsKey(s.id);
              return Positioned(
                top: (start - firstHour * 60) / 60 * rowHeight + 2,
                left: 3.w,
                right: 3.w,
                height: math.max(24.h, (end - start) / 60 * rowHeight - 4),
                child: Semantics(
                  button: true,
                  selected: picking ? picked : null,
                  label:
                      '${CalendarSlotStyle.label(context, kind)}: $title ${VenueFormat.time(context, s.startUtc)}',
                  child: GestureDetector(
                    onTap: () => onSlot(s),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 3.h,
                      ),
                      decoration: CalendarSlotStyle.decoration(kind).copyWith(
                        boxShadow: picked
                            ? [
                                const BoxShadow(
                                  color: AppColors.brandRed,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                      child: ExcludeSemantics(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.font11Bold.copyWith(
                                color: CalendarSlotStyle.foreground(kind),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${VenueFormat.time(context, s.startUtc)} – ${VenueFormat.time(context, s.endUtc)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.font10Regular.copyWith(
                                  color: CalendarSlotStyle.foreground(kind),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class _EmptyCell extends StatelessWidget {
  const _EmptyCell({
    required this.picked,
    required this.label,
    required this.onTap,
  });

  final bool picked;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$label: ${'venue.calendar.free_slot'.tr(context: context)}',
      selected: picked,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: picked ? AppColors.redLight : AppColors.white,
            border: Border(
              top: const BorderSide(color: Color(0xFFF1F3F7)),
              left: const BorderSide(color: AppColors.borderCard),
              bottom: picked
                  ? const BorderSide(color: AppColors.brandRed)
                  : BorderSide.none,
            ),
          ),
          alignment: Alignment.center,
          child: picked
              ? Text(
                  'venue.calendar.picked'.tr(context: context),
                  style: AppTextStyles.font11Bold.copyWith(
                    color: AppColors.brandRed,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
