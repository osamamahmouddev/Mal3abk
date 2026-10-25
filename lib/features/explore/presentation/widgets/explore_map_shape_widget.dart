import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// A rotated block on the illustrated map, positioned by its design-space center.
class ExploreMapShapeWidget extends StatelessWidget {
  const ExploreMapShapeWidget({
    required this.centerX,
    required this.centerY,
    required this.width,
    required this.height,
    super.key,
    this.degrees = 0,
    this.color,
    this.child,
  });

  final double centerX;
  final double centerY;
  final double width;
  final double height;
  final double degrees;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (centerX - width / 2).w,
      top: (centerY - height / 2).h,
      child: Transform.rotate(
        angle: degrees * math.pi / 180,
        child: Container(
          width: width.w,
          height: height.h,
          color: color,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
