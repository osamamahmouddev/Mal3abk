import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import 'location_distance_badge_widget.dart';

class LocationIllustrationWidget extends StatelessWidget {
  const LocationIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.r,
      height: 200.r,
      decoration: const BoxDecoration(
        color: AppColors.lightSurface,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 130.r,
            height: 130.r,
            decoration: const BoxDecoration(
              color: AppColors.lightSurfaceDeep,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 64.r,
            height: 64.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.brandNavy,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.icLocationPin,
              width: 30.r,
              height: 30.r,
            ),
          ),
          Positioned(
            left: 30.r,
            top: 26.r,
            child: LocationDistanceBadgeWidget(
              label: 'onboarding.location.badge1'.tr(context: context),
            ),
          ),
          Positioned(
            left: 134.r,
            top: 145.r,
            child: LocationDistanceBadgeWidget(
              label: 'onboarding.location.badge2'.tr(context: context),
            ),
          ),
        ],
      ),
    );
  }
}
