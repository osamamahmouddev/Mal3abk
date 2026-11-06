import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class VenueInfoHeaderWidget extends StatelessWidget {
  const VenueInfoHeaderWidget({
    required this.name,
    required this.address,
    super.key,
  });

  final String name;
  final String address;

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
              Expanded(child: Text(name, style: AppTextStyles.font21Bold)),
            ],
          ),
          hSpace(12),
          Row(
            children: [
              SvgPicture.asset(AppAssets.icPinGray, width: 14.r, height: 14.r),
              vSpace(4),
              Expanded(
                child: Text(
                  address,
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
