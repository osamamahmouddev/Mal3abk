import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';

/// Icon and tint for a notification category sent by the server.
class NotificationCategoryIcon {
  const NotificationCategoryIcon._();

  static (IconData, Color) of(String category) => switch (category) {
    'Bookings' => (Icons.event_available_rounded, AppColors.successGreen),
    'Payments' => (Icons.receipt_long_rounded, AppColors.goldDark),
    'Teams' => (Icons.sports_soccer_rounded, AppColors.brandNavy),
    'Security' => (Icons.shield_rounded, AppColors.brandRed),
    'Venues' => (Icons.stadium_rounded, AppColors.brandNavy),
    _ => (Icons.notifications_rounded, AppColors.offlineBanner),
  };
}
