import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class VenueInfoHeaderWidget extends StatelessWidget {
  const VenueInfoHeaderWidget({
    this.name,
    this.address,
    this.rating,
    super.key,
  });

  final String? name;
  final String? address;
  final String? rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name ?? 'explore.venue.name'.tr(context: context),
                  style: AppTextStyles.font21Bold,
                ),
              ),
              Text(
                '★ ${rating ?? 'explore.sample1_rating'.tr(context: context)}',
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.goldDark,
                ),
              ),
            ],
          ),
          hSpace(12),
          Row(
            children: [
              SvgPicture.asset(AppAssets.icPinGray, width: 14.r, height: 14.r),
              vSpace(4),
              Expanded(
                child: Text(
                  address ?? 'explore.venue.address'.tr(context: context),
                  style: AppTextStyles.font13Regular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
