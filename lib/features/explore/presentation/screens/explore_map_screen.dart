import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../widgets/explore_map_backdrop_widget.dart';
import '../widgets/explore_map_locate_button_widget.dart';
import '../widgets/explore_map_pins_layer_widget.dart';
import '../widgets/explore_map_top_overlay_widget.dart';
import '../widgets/explore_map_venue_sheet_widget.dart';

class ExploreMapScreen extends StatelessWidget {
  const ExploreMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mapBackground,
      body: Stack(
        children: [
          const Positioned.fill(child: ExploreMapBackdropWidget()),
          const Positioned.fill(child: ExploreMapPinsLayerWidget()),
          const SafeArea(child: ExploreMapTopOverlayWidget()),
          Positioned(
            left: 12.w,
            right: 12.w,
            bottom: 16.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 4.w),
                  child: const ExploreMapLocateButtonWidget(),
                ),
                const ExploreMapVenueSheetWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
