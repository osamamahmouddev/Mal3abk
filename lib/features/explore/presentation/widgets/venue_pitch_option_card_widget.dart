import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class VenuePitchOptionCardWidget extends StatelessWidget {
  const VenuePitchOptionCardWidget({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: onTap,
      borderRadius: 18,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.font15Bold),
                hSpace(4),
                Text(subtitle, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: price,
              style: AppTextStyles.font15Bold,
              children: [
                TextSpan(
                  text: 'explore.venue.per_hour_short'.tr(context: context),
                  style: AppTextStyles.font12Medium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
