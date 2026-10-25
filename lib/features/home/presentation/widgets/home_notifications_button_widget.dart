import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';

class HomeNotificationsButtonWidget extends StatelessWidget {
  const HomeNotificationsButtonWidget({
    required this.onTap,
    super.key,
    this.hasUnread = true,
  });

  final VoidCallback onTap;
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.r);

    return Material(
      color: AppColors.lightGrayBackground,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          width: 44.r,
          height: 44.r,
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(AppAssets.icBell, width: 22.r, height: 22.r),
              if (hasUnread)
                PositionedDirectional(
                  end: -1.r,
                  top: -2.r,
                  child: Container(
                    width: 13.r,
                    height: 13.r,
                    decoration: BoxDecoration(
                      color: AppColors.brandRed,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.lightGrayBackground,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
