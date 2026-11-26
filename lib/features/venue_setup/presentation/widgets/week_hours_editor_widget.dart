import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../data/models/venue_setup_form.dart';

/// One row per weekday (from Saturday): open switch and hours. A close
/// after midnight counts on the opening day.
class WeekHoursEditorWidget extends StatelessWidget {
  const WeekHoursEditorWidget({
    required this.week,
    required this.onChanged,
    super.key,
  });

  final Map<int, DayHours> week;
  final void Function(int day, DayHours hours) onChanged;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String t(String key) => 'venue.setup.hours.$key'.tr(context: context);
    return Column(
      children: [
        for (final d in DayHours.dayOrder)
          if (week[d] case final day?)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: CustomCardWidget(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            // 2026-01-04 is a Sunday (.NET day 0).
                            intl.DateFormat(
                              'EEEE',
                              lang,
                            ).format(DateTime(2026, 1, 4 + d)),
                            style: AppTextStyles.font14Bold,
                          ),
                        ),
                        if (!day.on)
                          Text(
                            t('closed'),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        Switch(
                          value: day.on,
                          onChanged: (on) => onChanged(d, day.copyWith(on: on)),
                        ),
                      ],
                    ),
                    if (day.on)
                      Row(
                        children: [
                          Text(t('from'), style: AppTextStyles.font13Regular),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: HalfHourTimeDropdownWidget(
                              value: day.open,
                              onChanged: (v) =>
                                  onChanged(d, day.copyWith(open: v)),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(t('to'), style: AppTextStyles.font13Regular),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: HalfHourTimeDropdownWidget(
                              value: day.close,
                              onChanged: (v) =>
                                  onChanged(d, day.copyWith(close: v)),
                            ),
                          ),
                        ],
                      ),
                    if (day.on && day.close.compareTo(day.open) <= 0)
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            day.open == day.close
                                ? t('all_day')
                                : t('next_day_close'),
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}

/// Every half hour from 6 AM, so a late closing time sits at the end.
class HalfHourTimeDropdownWidget extends StatelessWidget {
  const HalfHourTimeDropdownWidget({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String value;
  final ValueChanged<String> onChanged;

  static final List<String> times = [
    for (var i = 0; i < 48; i++)
      () {
        final m = (6 * 60 + i * 30) % (24 * 60);
        return '${(m ~/ 60).toString().padLeft(2, '0')}:${(m % 60).toString().padLeft(2, '0')}';
      }(),
  ];

  /// "18:30" → "٦:٣٠ م".
  static String label(BuildContext context, String hhmm) {
    final parts = hhmm.split(':');
    final lang = context.locale.languageCode;
    final text = intl.DateFormat(
      'h:mm a',
      lang,
    ).format(DateTime(2000, 1, 1, int.parse(parts[0]), int.parse(parts[1])));
    return lang == 'ar' ? text.toArabicDigits() : text;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: times.contains(value) ? value : null,
      hint: Text(label(context, value)),
      items: [
        for (final v in times)
          DropdownMenuItem(value: v, child: Text(label(context, v))),
      ],
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}
