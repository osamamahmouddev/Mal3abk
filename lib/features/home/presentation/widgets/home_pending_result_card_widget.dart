import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class HomePendingResultCardWidget extends StatelessWidget {
  const HomePendingResultCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      borderRadius: 18,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.submitResult),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.pending_result_title'.tr(context: context),
                  style: AppTextStyles.font14Bold,
                ),
                hSpace(2),
                Text(
                  'home.pending_result_sub'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
              ],
            ),
          ),
          Text(
            'home.review'.tr(context: context),
            style: AppTextStyles.font12Bold.copyWith(
              color: AppColors.brandNavy,
            ),
          ),
        ],
      ),
    );
  }
}
