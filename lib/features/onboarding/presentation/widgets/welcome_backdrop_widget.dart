import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/app_assets.dart';

class WelcomeBackdropWidget extends StatelessWidget {
  const WelcomeBackdropWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      start: -85.w,
      top: -40.h,
      child: IgnorePointer(
        child: RepaintBoundary(
          child: Transform.rotate(
            angle: -8 * math.pi / 180,
            child: SvgPicture.asset(
              AppAssets.welcomePitchLinesSvg,
              width: 560.w,
              height: 860.h,
            ),
          ),
        ),
      ),
    );
  }
}
