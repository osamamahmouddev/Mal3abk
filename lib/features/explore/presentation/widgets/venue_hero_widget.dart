import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import 'venue_hero_button_widget.dart';

class VenueHeroWidget extends StatelessWidget {
  const VenueHeroWidget({
    super.key,
    this.photoCount = 3,
    this.activePhoto = 0,
  });

  final int photoCount;
  final int activePhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.h,
      color: AppColors.pitchGreenLight,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(AppAssets.pitchHero, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VenueHeroButtonWidget(
                    iconAsset: AppAssets.icArrowBack20,
                    mirrorInLtr: true,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  VenueHeroButtonWidget(
                    iconAsset: AppAssets.icHeartFilled,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 12.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < photoCount; i++) ...[
                  if (i > 0) vSpace(5),
                  Container(
                    width: (i == activePhoto ? 18 : 6).w,
                    height: 6.r,
                    decoration: BoxDecoration(
                      color: i == activePhoto
                          ? AppColors.white
                          : AppColors.white60,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
