import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';

class BookingLocationCardWidget extends StatelessWidget {
  const BookingLocationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderCard),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RepaintBoundary(
            child: Container(
              height: 110.h,
              color: AppColors.mapBackground,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -6 * math.pi / 180,
                    child: Container(
                      width: 440.w,
                      height: 14.h,
                      color: AppColors.white,
                    ),
                  ),
                  Transform.rotate(
                    angle: 10 * math.pi / 180,
                    child: Container(
                      width: 12.w,
                      height: 160.h,
                      color: AppColors.white,
                    ),
                  ),
                  Transform.rotate(
                    angle: -45 * math.pi / 180,
                    child: Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: AppColors.brandRed,
                        border: Border.all(color: AppColors.white, width: 3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          topRight: Radius.circular(18.r),
                          bottomRight: Radius.circular(18.r),
                          bottomLeft: Radius.circular(2.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'booking.details.address'.tr(context: context),
                  style: AppTextStyles.font14SemiBold,
                ),
                hSpace(4),
                Text(
                  'booking.details.address_meta'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
