import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_chip_widget.dart';

/// Day, kick-off hour and duration for a challenge, all in Cairo time.
class ChallengeSchedulePickerWidget extends StatelessWidget {
  const ChallengeSchedulePickerWidget({
    required this.day,
    required this.hour,
    required this.durationMinutes,
    required this.onDayChanged,
    required this.onHourChanged,
    required this.onDurationChanged,
    super.key,
  });

  static const int daysAhead = 14;
  static const List<int> hours = [14, 15, 16, 17, 18, 19, 20, 21, 22, 23];
  static const List<int> durations = [60, 90, 120];

  final DateTime day;
  final int hour;
  final int durationMinutes;
  final ValueChanged<DateTime> onDayChanged;
  final ValueChanged<int> onHourChanged;
  final ValueChanged<int> onDurationChanged;

  /// The first day and hour still in the future, preferring [preferredHour].
  static (DateTime, int) firstAvailable({int preferredHour = 20}) {
    final now = CairoTime.now();
    final today = CairoTime.today();
    if (preferredHour > now.hour) return (today, preferredHour);
    final later = hours.where((h) => h > now.hour);
    if (later.isNotEmpty) return (today, later.first);
    return (today.add(const Duration(days: 1)), preferredHour);
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final today = CairoTime.today();
    final nowHour = CairoTime.now().hour;
    final isToday = day == today;
    String t(String key) => 'matches.schedule.$key'.tr(context: context);

    void select(VoidCallback change) {
      HapticFeedback.selectionClick();
      change();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t('day'), style: AppTextStyles.font15Bold),
        hSpace(10),
        SizedBox(
          height: 66.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: daysAhead,
            separatorBuilder: (_, _) => vSpace(8),
            itemBuilder: (context, index) {
              final option = today.add(Duration(days: index));
              final selected = option == day;
              final fg = selected ? AppColors.white : AppColors.textPrimary;
              return GestureDetector(
                onTap: () => select(() => onDayChanged(option)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 58.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.brandNavy : AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: selected
                          ? AppColors.brandNavy
                          : AppColors.borderInput,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        index == 0
                            ? t('today')
                            : CairoTime.weekday(option, lang),
                        style: AppTextStyles.font11Regular.copyWith(
                          color: selected
                              ? AppColors.onNavyMuted
                              : AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        option.day.toLocalizedDigits(lang),
                        style: AppTextStyles.font15Bold.copyWith(color: fg),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        hSpace(18),
        Text(t('hour'), style: AppTextStyles.font15Bold),
        hSpace(10),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (final option in hours)
              if (!isToday || option > nowHour)
                CustomChipWidget(
                  label: CairoTime.hourLabel(option, lang),
                  isSelected: option == hour,
                  onTap: () => select(() => onHourChanged(option)),
                ),
          ],
        ),
        hSpace(18),
        Text(t('duration'), style: AppTextStyles.font15Bold),
        hSpace(10),
        Wrap(
          spacing: 8.w,
          children: [
            for (final option in durations)
              CustomChipWidget(
                label: 'matches.minutes'.tr(
                  context: context,
                  args: [option.toLocalizedDigits(lang)],
                ),
                isSelected: option == durationMinutes,
                onTap: () => select(() => onDurationChanged(option)),
              ),
          ],
        ),
      ],
    );
  }
}
