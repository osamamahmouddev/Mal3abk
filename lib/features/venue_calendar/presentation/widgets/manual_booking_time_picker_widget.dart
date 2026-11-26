import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../calendar_layout.dart';
import '../cubit/manual_booking_cubit.dart';
import '../cubit/venue_calendar_cubit.dart';

/// Hour, minute and period (morning or night). Hours after 12 at night are
/// tied to the same night's session, like the web form.
class ManualBookingTimePickerWidget extends StatelessWidget {
  const ManualBookingTimePickerWidget({
    required this.date,
    required this.minutes,
    required this.onChanged,
    this.error,
    super.key,
  });

  final DateTime date;
  final int minutes;
  final ValueChanged<int> onChanged;
  final String? error;

  static const _quick = [20, 21, 22, 23, 24, 25, 26];

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.manual.time.$key'.tr(context: context);
    final parts = BusinessClock.fromMinutes(minutes);
    final lang = context.locale.languageCode;
    String n(int v) => lang == 'ar' ? '$v'.toArabicDigits() : '$v';

    final startUtc = VenueCalendarCubit.dayStartUtc(
      date,
    ).add(Duration(minutes: minutes));
    final day = VenueFormat.day(context, date);
    final summary = minutes >= 1440
        ? 'venue.manual.time.late_summary'.tr(
            context: context,
            args: [
              day,
              lang == 'ar'
                  ? intl.DateFormat('EEEE d MMMM', lang)
                        .format(CalendarLayout.localDate(startUtc))
                        .toArabicDigits()
                  : intl.DateFormat(
                      'EEEE d MMMM',
                      lang,
                    ).format(CalendarLayout.localDate(startUtc)),
              VenueFormat.time(context, startUtc.toIso8601String()),
            ],
          )
        : '$day، ${VenueFormat.time(context, startUtc.toIso8601String())}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t('label'), style: AppTextStyles.font14SemiBold),
        hSpace(2),
        Text(
          t('late_hint'),
          style: AppTextStyles.font11Regular.copyWith(
            color: AppColors.textMuted,
          ),
        ),
        hSpace(8),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: parts.hour12,
                decoration: InputDecoration(
                  labelText: t('hour'),
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
                items: [
                  for (var h = 1; h <= 12; h++)
                    DropdownMenuItem(value: h, child: Text(n(h))),
                ],
                onChanged: (h) => onChanged(
                  BusinessClock.toMinutes(h!, parts.minute, night: parts.night),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: parts.minute,
                decoration: InputDecoration(
                  labelText: t('minute'),
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
                items: [
                  for (final m in const [0, 15, 30, 45])
                    DropdownMenuItem(
                      value: m,
                      child: Text(n(m).padLeft(2, lang == 'ar' ? '٠' : '0')),
                    ),
                ],
                onChanged: (m) => onChanged(
                  BusinessClock.toMinutes(parts.hour12, m!, night: parts.night),
                ),
              ),
            ),
          ],
        ),
        hSpace(10),
        SegmentedButton<bool>(
          segments: [
            ButtonSegment(
              value: true,
              icon: const Icon(Icons.nightlight_round, size: 16),
              label: Text(t('night')),
            ),
            ButtonSegment(
              value: false,
              icon: const Icon(Icons.wb_sunny_rounded, size: 16),
              label: Text(t('morning')),
            ),
          ],
          selected: {parts.night},
          showSelectedIcon: false,
          onSelectionChanged: (s) => onChanged(
            BusinessClock.toMinutes(parts.hour12, parts.minute, night: s.first),
          ),
          style: SegmentedButton.styleFrom(
            selectedBackgroundColor: AppColors.brandNavy,
            selectedForegroundColor: AppColors.white,
          ),
        ),
        hSpace(10),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(t('quick'), style: AppTextStyles.font12Medium),
            for (final h in _quick)
              ChoiceChip(
                label: Text(
                  'venue.manual.time.night_at'.tr(
                    context: context,
                    args: [n(h % 12 == 0 ? 12 : h % 12)],
                  ),
                ),
                selected: minutes == h * 60,
                onSelected: (_) => onChanged(h * 60),
                showCheckmark: false,
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
        hSpace(10),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: minutes >= 1440
                ? const Color(0xFFEEF2FF)
                : AppColors.successLight,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 18.r,
                color: AppColors.brandNavy,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '${t('selected')} $summary',
                  style: AppTextStyles.font12SemiBold,
                ),
              ),
            ],
          ),
        ),
        if (error != null) ...[
          hSpace(4),
          Text(
            error!,
            style: AppTextStyles.font12SemiBold.copyWith(
              color: AppColors.redText,
            ),
          ),
        ],
      ],
    );
  }
}
