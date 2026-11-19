import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/animated_check_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// The receipt box once a photo is chosen: the photo itself, a check that draws itself, and what to do next.
class UploadProofReadyReceiptWidget extends StatelessWidget {
  const UploadProofReadyReceiptWidget({required this.bytes, super.key});

  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    final kilobytes = (bytes.lengthInBytes / 1024).round();

    return Padding(
      padding: EdgeInsets.all(14.r),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.memory(
              bytes,
              width: 84.r,
              height: 112.r,
              fit: BoxFit.cover,
              cacheWidth: 300,
              gaplessPlayback: true,
            ),
          ),
          vSpace(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedCheckWidget(
                  color: AppColors.successGreen,
                  size: 34.r,
                  strokeWidth: 3,
                  // A "ready" mark, not the success moment: no whistle.
                  burst: false,
                ),
                hSpace(8),
                Text(
                  'booking.upload.ready_title'.tr(context: context),
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.successGreen,
                  ),
                ),
                hSpace(4),
                Text(
                  'booking.upload.ready_size'.tr(
                    context: context,
                    namedArgs: {'kb': '$kilobytes'},
                  ),
                  style: AppTextStyles.font13Regular,
                ),
                hSpace(6),
                Text(
                  'booking.upload.change'.tr(context: context),
                  style: AppTextStyles.font13SemiBold.copyWith(
                    color: AppColors.brandNavy,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.brandNavy,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
