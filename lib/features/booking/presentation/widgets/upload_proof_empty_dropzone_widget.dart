import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// The receipt box before a photo is chosen.
class UploadProofEmptyDropzoneWidget extends StatelessWidget {
  const UploadProofEmptyDropzoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.lightSurface,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.icUpload,
              width: 26.r,
              height: 26.r,
            ),
          ),
          hSpace(8),
          Text(
            'booking.upload.title'.tr(context: context),
            style: AppTextStyles.font16Bold,
          ),
          hSpace(10),
          Text(
            'booking.upload.formats'.tr(context: context),
            style: AppTextStyles.font13Regular,
          ),
          hSpace(10),
          Text(
            'booking.upload.pick'.tr(context: context),
            style: AppTextStyles.font13SemiBold.copyWith(
              color: AppColors.brandNavy,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.brandNavy,
            ),
          ),
        ],
      ),
    );
  }
}
