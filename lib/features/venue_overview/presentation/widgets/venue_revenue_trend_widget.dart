import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_dashboard_model.dart';

/// Confirmed revenue per day over the last 30 days.
class VenueRevenueTrendWidget extends StatelessWidget {
  const VenueRevenueTrendWidget({required this.points, super.key});

  final List<RevenuePointModel> points;

  @override
  Widget build(BuildContext context) {
    final max = points.fold<double>(1, (m, p) => math.max(m, p.confirmedValue));
    final total = points.fold<double>(0, (s, p) => s + p.confirmedValue);
    final totalText = VenueFormat.money(context, total);

    return VenueSectionCardWidget(
      title: 'venue.overview.revenue_trend'.tr(context: context),
      trailing: Text(
        totalText,
        style: AppTextStyles.font14Bold.copyWith(color: AppColors.successGreen),
      ),
      child: Semantics(
        label: 'venue.overview.revenue_trend_label'.tr(
          context: context,
          args: [totalText],
        ),
        child: ExcludeSemantics(
          child: SizedBox(
            height: 90.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final p in points)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: Container(
                        height: math.max(2, (p.confirmedValue / max) * 90.h),
                        decoration: BoxDecoration(
                          color: AppColors.pitchGreen,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(2.r),
                          ),
                        ),
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
