import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_dashboard_model.dart';

/// Daily occupancy bars for the last 7 days or the 7 before them.
class VenueOccupancyCardWidget extends HookWidget {
  const VenueOccupancyCardWidget({
    required this.thisWeek,
    required this.lastWeek,
    super.key,
  });

  final List<OccupancyPointModel> thisWeek;
  final List<OccupancyPointModel> lastWeek;

  @override
  Widget build(BuildContext context) {
    final showThis = useState(true);
    String t(String key) =>
        'venue.overview.occupancy.$key'.tr(context: context);
    final points = showThis.value ? thisWeek : lastWeek;
    String weekday(String date) => intl.DateFormat(
      'EEE',
      context.locale.languageCode,
    ).format(DateTime.parse('${date}T12:00:00'));

    return VenueSectionCardWidget(
      title: t('title'),
      trailing: Container(
        padding: EdgeInsets.all(3.r),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RangeChip(
              text: t('last_7'),
              selected: showThis.value,
              onTap: () => showThis.value = true,
            ),
            _RangeChip(
              text: t('previous_7'),
              selected: !showThis.value,
              onTap: () => showThis.value = false,
            ),
          ],
        ),
      ),
      child: Semantics(
        label: 'venue.overview.occupancy.chart_label'.tr(
          context: context,
          args: [
            points
                .map((p) => '${weekday(p.date)} ${p.percent.round()}')
                .join('، '),
          ],
        ),
        child: ExcludeSemantics(
          child: SizedBox(
            height: 150.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final p in points)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            VenueFormat.percent(context, p.percent),
                            style: AppTextStyles.font10Bold.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          hSpace(4),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: (p.percent.clamp(0, 100) * 0.95.h)
                                .clamp(2, 100.h)
                                .toDouble(),
                            decoration: BoxDecoration(
                              color: AppColors.brandNavy,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(6.r),
                              ),
                            ),
                          ),
                          hSpace(6),
                          Text(
                            weekday(p.date),
                            style: AppTextStyles.font10Regular.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RangeChip extends StatelessWidget {
  const _RangeChip({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(minHeight: 30.h),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: selected ? AppColors.white : AppColors.transparent,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            text,
            style:
                (selected
                        ? AppTextStyles.font11Bold
                        : AppTextStyles.font11Regular)
                    .copyWith(
                      color: selected
                          ? AppColors.brandNavy
                          : AppColors.textSecondary,
                    ),
          ),
        ),
      ),
    );
  }
}
