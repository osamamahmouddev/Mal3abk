import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../data/models/calendar_slot_model.dart';

/// The web calendar's colour for each kind of taken slot.
abstract final class CalendarSlotStyle {
  static String label(BuildContext context, CalendarSlotKind kind) =>
      'venue.calendar.kind.${kind.name}'.tr(context: context);

  static AppBadgeType badge(CalendarSlotKind kind) => switch (kind) {
    CalendarSlotKind.confirmed => AppBadgeType.success,
    CalendarSlotKind.review => AppBadgeType.warning,
    CalendarSlotKind.blocked => AppBadgeType.neutral,
    _ => AppBadgeType.accent,
  };

  static Color foreground(CalendarSlotKind kind) => switch (kind) {
    CalendarSlotKind.confirmed => AppColors.white,
    CalendarSlotKind.review => AppColors.goldText,
    CalendarSlotKind.blocked => AppColors.offlineBanner,
    _ => AppColors.brandNavy,
  };

  static BoxDecoration decoration(CalendarSlotKind kind) {
    final radius = BorderRadius.circular(6.r);
    return switch (kind) {
      CalendarSlotKind.confirmed => BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: radius,
      ),
      CalendarSlotKind.tentative => BoxDecoration(
        color: const Color(0xFFEEF1F7),
        borderRadius: radius,
        border: Border.all(color: AppColors.brandNavy, width: 1.5),
      ),
      CalendarSlotKind.review => BoxDecoration(
        color: AppColors.goldLight,
        borderRadius: radius,
        border: Border.all(color: const Color(0xFFD9A21B), width: 1.5),
      ),
      CalendarSlotKind.waiting => BoxDecoration(
        color: AppColors.white,
        borderRadius: radius,
        border: Border.all(color: AppColors.textDisabled, width: 1.5),
      ),
      CalendarSlotKind.blocked => BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: AppColors.borderInput),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(-0.6, -0.4),
          colors: [AppColors.lightSurfaceDeep, Color(0xFFEEF0F5)],
          stops: [0.5, 0.5],
          tileMode: TileMode.repeated,
        ),
      ),
    };
  }
}
