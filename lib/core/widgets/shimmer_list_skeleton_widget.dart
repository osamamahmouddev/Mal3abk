import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../animations/turf_shimmer_widget.dart';
import '../app/app_spaces.dart';
import '../styles/app_colors.dart';

/// Placeholder cards with the exact height of the content they stand in for.
///
/// Inside another scrollable (the home feed) it takes its natural height; with
/// a bounded height it clips like a list instead of overflowing.
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
    final cards = Padding(
      padding: padding ?? EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < itemCount; i++) ...[
            if (i > 0) hSpace(spacing),
            Container(
              height: itemHeight.h,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(borderRadius.r),
              ),
            ),
          ],
        ],
      ),
    );

    return TurfShimmerWidget(
      child: LayoutBuilder(
        builder: (context, constraints) => constraints.hasBoundedHeight
            ? SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: cards,
              )
            : cards,
      ),
    );
  }
}
