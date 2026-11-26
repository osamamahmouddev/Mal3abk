import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/calendar_slot_model.dart';
import '../calendar_layout.dart';

/// The month's days with how many bookings (and reviews) each has; a tap
/// opens that day.
class CalendarMonthGridWidget extends StatelessWidget {
  const CalendarMonthGridWidget({
    required this.date,
    required this.slots,
    required this.onOpenDay,
    super.key,
  });

  final DateTime date;
  final List<CalendarSlotModel> slots;
  final ValueChanged<DateTime> onOpenDay;

  @override
  Widget build(BuildContext context) {
    final first = DateTime(date.year, date.month);
    final days = DateTime(date.year, date.month + 1, 0).day;
    final lead = (first.weekday + 1) % 7;
    final today = CairoTime.today();
    final lang = context.locale.languageCode;
    final byDay = <DateTime, List<CalendarSlotModel>>{};
    for (final s in slots.where((s) => !s.isBlocked)) {
      byDay.putIfAbsent(CalendarLayout.localDate(s.start), () => []).add(s);
    }
    // Saturday first.
    final weekdayNames = [
      for (var i = 0; i < 7; i++)
        intl.DateFormat('EEE', lang).format(DateTime(2026, 1, 3 + i)),
    ];

    return ListView(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 24.h),
      children: [
        Row(
          children: [
            for (final name in weekdayNames)
              Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font11Bold.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 6.h),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 4.h,
          crossAxisSpacing: 4.w,
          childAspectRatio: 0.72,
          children: [
            for (var i = 0; i < lead; i++) const SizedBox.shrink(),
            for (var d = 1; d <= days; d++)
              Builder(
                builder: (context) {
                  final day = DateTime(date.year, date.month, d);
                  final list = byDay[day] ?? const [];
                  final review = list
                      .where((s) => s.kind == CalendarSlotKind.review)
                      .length;
                  final isToday = day == today;
                  return Semantics(
                    button: true,
                    label:
                        '${VenueFormat.day(context, day)}: ${'venue.calendar.month_count'.tr(context: context, args: [VenueFormat.number(context, list.length)])}',
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () => onOpenDay(day),
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isToday
                                ? AppColors.brandRed
                                : AppColors.borderCard,
                            width: isToday ? 1.5 : 1,
                          ),
                        ),
                        child: ExcludeSemantics(
                          child: Column(
                            children: [
                              Text(
                                VenueFormat.number(context, d),
                                style: AppTextStyles.font13Bold,
                              ),
                              const Spacer(),
                              if (list.isNotEmpty)
                                Text(
                                  VenueFormat.number(context, list.length),
                                  style: AppTextStyles.font12Bold.copyWith(
                                    color: AppColors.brandNavy,
                                  ),
                                ),
                              if (review > 0)
                                Container(
                                  margin: EdgeInsets.only(top: 2.h),
                                  width: 6.r,
                                  height: 6.r,
                                  decoration: const BoxDecoration(
                                    color: AppColors.accentGold,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}
