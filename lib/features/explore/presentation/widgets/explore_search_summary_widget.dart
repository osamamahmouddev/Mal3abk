import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import 'explore_filter_button_widget.dart';

class ExploreSearchSummaryWidget extends StatelessWidget {
  const ExploreSearchSummaryWidget({
    super.key,
    this.floating = false,
    this.subtitleKey = 'explore.summary_when',
    this.activeFilters = 0,
  });

  /// White with shadow when floating over the map; gray when inline.
  final bool floating;
  final String subtitleKey;
  final int activeFilters;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14.r);
    final shadow = floating
        ? [
            BoxShadow(
              color: AppColors.navyShadow12,
              offset: Offset(0, 2.h),
              blurRadius: 8.r,
            ),
          ]
        : null;
    final background =
        floating ? AppColors.white : AppColors.lightGrayBackground;

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: radius, boxShadow: shadow),
            child: Material(
              color: background,
              borderRadius: radius,
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.filtersAndSort),
                borderRadius: radius,
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.icSearch, width: 18.r, height: 18.r),
                      vSpace(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'explore.summary_area'.tr(context: context),
                            style: AppTextStyles.font14Bold,
                          ),
                          Text(
                            subtitleKey.tr(context: context),
                            style: AppTextStyles.font11Regular,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        vSpace(8),
        ExploreFilterButtonWidget(
          background: background,
          shadow: shadow,
          activeFilters: activeFilters,
        ),
      ],
    );
  }
}
