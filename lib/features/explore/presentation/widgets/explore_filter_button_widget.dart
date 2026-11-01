import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ExploreFilterButtonWidget extends StatelessWidget {
  const ExploreFilterButtonWidget({
    required this.background,
    super.key,
    this.shadow,
    this.activeFilters = 0,
  });

  final Color background;
  final List<BoxShadow>? shadow;
  final int activeFilters;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14.r);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: radius, boxShadow: shadow),
          child: Material(
            color: background,
            borderRadius: radius,
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.filtersAndSort),
              borderRadius: radius,
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: SvgPicture.asset(
                  AppAssets.icFilter,
                  width: 20.r,
                  height: 20.r,
                ),
              ),
            ),
          ),
        ),
        if (activeFilters > 0)
          PositionedDirectional(
            end: -4.r,
            top: -4.r,
            child: Container(
              width: 20.r,
              height: 20.r,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.brandRed,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$activeFilters',
                style: AppTextStyles.font11Bold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
