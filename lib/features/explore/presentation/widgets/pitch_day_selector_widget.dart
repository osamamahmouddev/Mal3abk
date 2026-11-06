import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/utils/cairo_time.dart';
import 'pitch_day_tile_widget.dart';

/// The next [days] Cairo calendar days, starting today.
class PitchDaySelectorWidget extends StatelessWidget {
  const PitchDaySelectorWidget({
    required this.selectedIndex,
    required this.onSelect,
    super.key,
  });

  static const int days = 7;

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final today = CairoTime.today();

    return SizedBox(
      height: 64.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: days,
        separatorBuilder: (_, _) => vSpace(6),
        itemBuilder: (context, i) {
          final day = today.add(Duration(days: i));
          return SizedBox(
            width: 52.w,
            child: PitchDayTileWidget(
              dayName: i == 0
                  ? 'matches.schedule.today'.tr(context: context)
                  : CairoTime.weekday(day, lang),
              dayNumber: day.day.toLocalizedDigits(lang),
              isSelected: selectedIndex == i,
              onTap: () {
                HapticFeedback.selectionClick();
                onSelect(i);
              },
            ),
          );
        },
      ),
    );
  }
}
