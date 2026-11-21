import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// A small gold tag for a running discount ("20% off · until 27 November").
class OfferBadgeWidget extends StatelessWidget {
  const OfferBadgeWidget({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(8.w, 4.h, 10.w, 4.h),
      decoration: BoxDecoration(
        color: AppColors.goldLight,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.goldBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_offer_rounded,
            size: 13.r,
            color: AppColors.goldDark,
          ),
          vSpace(5),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font12Bold.copyWith(
                color: AppColors.goldText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
