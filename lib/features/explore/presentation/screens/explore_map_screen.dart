import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../widgets/explore_map_selection_bloc_builder.dart';
import '../widgets/explore_map_top_overlay_widget.dart';
import '../widgets/explore_map_view_bloc_consumer.dart';

class ExploreMapScreen extends StatelessWidget {
  const ExploreMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The map has rounded bottom corners; this shows behind them, matching
      // the strip the nav bar sits on.
      backgroundColor: AppColors.pageBackground,
      body: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(28.r),
              ),
              child: const ColoredBox(
                color: AppColors.mapBackground,
                child: ExploreMapViewBlocConsumer(),
              ),
            ),
          ),
          const SafeArea(child: ExploreMapTopOverlayWidget()),
          Positioned(
            left: 12.w,
            right: 12.w,
            bottom: 16.h,
            child: const SafeArea(
              top: false,
              child: ExploreMapSelectionBlocBuilder(),
            ),
          ),
        ],
      ),
    );
  }
}
