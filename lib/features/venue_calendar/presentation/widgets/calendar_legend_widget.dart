import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../data/models/calendar_slot_model.dart';
import 'calendar_slot_style.dart';

class CalendarLegendWidget extends StatelessWidget {
  const CalendarLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'venue.calendar.legend'.tr(context: context),
      child: SizedBox(
        height: 36.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          children: [
            for (final kind in CalendarSlotKind.values)
              Padding(
                padding: EdgeInsetsDirectional.only(end: 14.w),
                child: Row(
                  children: [
                    Container(
                      width: 14.r,
                      height: 14.r,
                      decoration: CalendarSlotStyle.decoration(kind),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      CalendarSlotStyle.label(context, kind),
                      style: AppTextStyles.font12Medium.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
