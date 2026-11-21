import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_card_widget.dart';

/// The team invite preview card while it loads, in the real card's shape:
/// avatar and two text lines, so nothing jumps once the team arrives.
class TeamInvitePreviewSkeletonWidget extends StatelessWidget {
  const TeamInvitePreviewSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: CustomCardWidget(
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            Container(
              width: 48.r,
              height: 48.r,
              decoration: const BoxDecoration(
                color: AppColors.lightSurface,
                shape: BoxShape.circle,
              ),
            ),
            vSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 130.w, height: 16.h, decoration: block),
                  hSpace(8),
                  Container(width: 160.w, height: 12.h, decoration: block),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
