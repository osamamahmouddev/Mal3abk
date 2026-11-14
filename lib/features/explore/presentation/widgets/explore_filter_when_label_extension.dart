import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/utils/cairo_time.dart';
import '../../data/models/explore_filter_model.dart';

/// "الخميس ٢٠ · ٨:٠٠ م": the day and time an Explore search is for.
extension ExploreFilterWhenLabel on ExploreFilterModel {
  /// Whether the player picked a day or an exact hour (the home card does).
  bool get hasPickedWhen => day != null || startHour != null;

  /// Null when the search is for any time.
  String? whenLabel(BuildContext context) {
    if (day == null && startHour == null && timeWindow == null) return null;
    final lang = context.locale.languageCode;
    final dayText = CairoTime.dayLabel(
      day ?? CairoTime.today(),
      lang,
      today: 'home.today'.tr(context: context),
      tomorrow: 'home.tomorrow'.tr(context: context),
    );
    final hour = startHour;
    final window = timeWindow;
    final timeText = hour != null
        ? CairoTime.clockLabel(hour, lang)
        : window != null
        ? 'explore.filters.time_${window.name}'.tr(context: context)
        : 'explore.summary_when_any'.tr(context: context);
    return 'explore.summary_when_picked'.tr(
      context: context,
      args: [dayText, timeText],
    );
  }
}
