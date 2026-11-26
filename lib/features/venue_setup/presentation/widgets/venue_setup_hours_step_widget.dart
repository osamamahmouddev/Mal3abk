import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../data/models/venue_setup_form.dart';
import '../cubit/venue_setup_cubit.dart';
import '../cubit/venue_setup_state.dart';

/// Step 3: weekly opening hours. A close after midnight counts on the
/// opening day.
class VenueSetupHoursStepWidget extends StatelessWidget {
  const VenueSetupHoursStepWidget({super.key});

  /// Every half hour from 6 AM, so a late close sits at the end.
  static final List<String> _times = [
    for (var i = 0; i < 48; i++)
      () {
        final m = (6 * 60 + i * 30) % (24 * 60);
        return '${(m ~/ 60).toString().padLeft(2, '0')}:${(m % 60).toString().padLeft(2, '0')}';
      }(),
  ];

  static String timeLabel(BuildContext context, String hhmm) {
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
    final cubit = context.read<VenueSetupCubit>();
    final lang = context.locale.languageCode;
    String t(String key) => 'venue.setup.hours.$key'.tr(context: context);

    return BlocBuilder<VenueSetupCubit, VenueSetupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t('intro'),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            hSpace(12),
            for (final d in DayHours.dayOrder)
              if (state.week[d] case final day?)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: CustomCardWidget(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                intl.DateFormat('EEEE', lang).format(
                                  // 2026-01-04 is a Sunday (.NET day 0).
                                  DateTime(2026, 1, 4 + d),
                                ),
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
                              onChanged: (on) =>
                                  cubit.setDay(d, day.copyWith(on: on)),
                            ),
                          ],
                        ),
                        if (day.on)
                          Row(
                            children: [
                              Text(
                                t('from'),
                                style: AppTextStyles.font13Regular,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: _TimeDropdown(
                                  value: day.open,
                                  times: _times,
                                  onChanged: (v) =>
                                      cubit.setDay(d, day.copyWith(open: v)),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(t('to'), style: AppTextStyles.font13Regular),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: _TimeDropdown(
                                  value: day.close,
                                  times: _times,
                                  onChanged: (v) =>
                                      cubit.setDay(d, day.copyWith(close: v)),
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
            hSpace(8),
            CustomButton(
              text: t('save_next'),
              height: 52.h,
              borderRadius: 14,
              isLoading: state.saving,
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: cubit.saveSchedules,
            ),
          ],
        );
      },
    );
  }
}

class _TimeDropdown extends StatelessWidget {
  const _TimeDropdown({
    required this.value,
    required this.times,
    required this.onChanged,
  });

  final String value;
  final List<String> times;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: times.contains(value) ? value : null,
      hint: Text(VenueSetupHoursStepWidget.timeLabel(context, value)),
      items: [
        for (final v in times)
          DropdownMenuItem(
            value: v,
            child: Text(VenueSetupHoursStepWidget.timeLabel(context, v)),
          ),
      ],
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}
