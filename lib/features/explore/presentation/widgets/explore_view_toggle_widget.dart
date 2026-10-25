import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import 'explore_view_toggle_segment_widget.dart';

class ExploreViewToggleWidget extends StatelessWidget {
  const ExploreViewToggleWidget({required this.isMap, super.key});

  /// On the map the toggle floats (white, shadow, larger segments).
  final bool isMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: isMap ? AppColors.white : AppColors.lightGrayBackground,
        borderRadius: BorderRadius.circular((isMap ? 20 : 18).r),
        boxShadow: isMap
            ? [
                BoxShadow(
                  color: AppColors.navyShadow12,
                  offset: Offset(0, 2.h),
                  blurRadius: 8.r,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExploreViewToggleSegmentWidget(
            labelKey: 'explore.view_list',
            isActive: !isMap,
            route: AppRoutes.exploreList,
            large: isMap,
          ),
          ExploreViewToggleSegmentWidget(
            labelKey: 'explore.view_map',
            isActive: isMap,
            route: AppRoutes.exploreMap,
            large: isMap,
          ),
        ],
      ),
    );
  }
}
