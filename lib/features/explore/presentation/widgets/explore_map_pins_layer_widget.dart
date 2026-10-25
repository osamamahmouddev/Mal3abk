import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'explore_map_pin_widget.dart';

class ExploreMapPinsLayerWidget extends StatelessWidget {
  const ExploreMapPinsLayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 270.w,
          top: 250.h,
          child: ExploreMapPinWidget(label: 'explore.pin_180'.tr(context: context)),
        ),
        Positioned(
          left: 60.w,
          top: 470.h,
          child: ExploreMapPinWidget(label: 'explore.pin_200'.tr(context: context)),
        ),
        Positioned(
          left: 120.w,
          top: 560.h,
          child: ExploreMapPinWidget(label: 'explore.pin_140'.tr(context: context)),
        ),
        Positioned(
          left: 300.w,
          top: 430.h,
          child: ExploreMapPinWidget(
            label: 'explore.pin_booked'.tr(context: context),
            type: ExploreMapPinType.booked,
          ),
        ),
        Positioned(
          left: 210.w,
          top: 358.h,
          child: ExploreMapPinWidget(
            label: 'explore.pin_150'.tr(context: context),
            type: ExploreMapPinType.selected,
          ),
        ),
      ],
    );
  }
}
