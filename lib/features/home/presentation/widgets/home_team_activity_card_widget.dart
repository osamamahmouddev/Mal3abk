import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class HomeTeamActivityCardWidget extends StatelessWidget {
  const HomeTeamActivityCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.brandNavy,
            child: Text('نج', style: AppTextStyles.font12Bold.copyWith(color: AppColors.white)),
          ),
          vSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.sample_challenge_text'.tr(context: context),
                  style: AppTextStyles.font13SemiBold,
                ),
                hSpace(2),
                Text(
                  'home.sample_challenge_time'.tr(context: context),
                  style: AppTextStyles.font11Regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
