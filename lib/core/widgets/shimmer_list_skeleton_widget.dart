import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';

/// Placeholder cards with the exact height of the content they stand in for.
class ShimmerListSkeletonWidget extends StatelessWidget {
  const ShimmerListSkeletonWidget({
    required this.itemHeight,
    this.itemCount = 4,
    this.borderRadius = 18,
    this.spacing = 12,
    this.padding,
    super.key,
  });

  final double itemHeight;
  final int itemCount;
  final double borderRadius;
  final double spacing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightSurface,
      highlightColor: AppColors.white,
      child: ListView.separated(
        padding: padding ?? EdgeInsets.all(16.r),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, _) => hSpace(spacing),
        itemBuilder: (_, _) => Container(
          height: itemHeight.h,
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
      ),
    );
  }
}
