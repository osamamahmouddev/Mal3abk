import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_shadows.dart';
import '../styles/app_text_styles.dart';
import 'bottom_action_bar_widget.dart';
import 'custom_button.dart';

/// Bottom bar with a caption + big price on the start and a red CTA on the end.
class PriceActionFooterWidget extends StatelessWidget {
  const PriceActionFooterWidget({
    required this.caption,
    required this.price,
    required this.ctaText,
    required this.onTap,
    super.key,
    this.priceSuffix,
  });

  final String caption;
  final String price;
  final String? priceSuffix;
  final String ctaText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BottomActionBarWidget(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(caption, style: AppTextStyles.font12Regular),
                Text.rich(
                  TextSpan(
                    text: price,
                    style: AppTextStyles.font20Bold,
                    children: [
                      if (priceSuffix != null)
                        TextSpan(
                          text: priceSuffix,
                          style: AppTextStyles.font12Medium,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
            text: ctaText,
            height: 52.h,
            borderRadius: 12,
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            boxShadow: AppShadows.redGlow,
            textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
