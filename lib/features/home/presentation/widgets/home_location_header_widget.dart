import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import 'home_notifications_button_widget.dart';

class HomeLocationHeaderWidget extends StatelessWidget {
  const HomeLocationHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 14.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.current_location'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
                hSpace(2),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.icPinSmall,
                      width: 16.r,
                      height: 16.r,
                    ),
                    vSpace(6),
                    Text(
                      'home.default_city'.tr(context: context),
                      style: AppTextStyles.font16Bold,
                    ),
                    vSpace(2),
                    SvgPicture.asset(
                      AppAssets.icChevronDown,
                      width: 14.r,
                      height: 14.r,
                    ),
                  ],
                ),
              ],
            ),
          ),
          HomeNotificationsButtonWidget(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.notifications),
          ),
        ],
      ),
    );
  }
}
