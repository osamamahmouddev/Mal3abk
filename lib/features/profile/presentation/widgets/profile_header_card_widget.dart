import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import 'profile_stat_widget.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  const ProfileHeaderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 36.r,
                backgroundColor: AppColors.white,
                child: Text(
                  'أس',
                  style: AppTextStyles.font22Bold.copyWith(
                    color: AppColors.brandNavy,
                  ),
                ),
              ),
              vSpace(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أحمد سامي',
                      style: AppTextStyles.font20Bold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    hSpace(2),
                    Text(
                      'مدينة نصر · وسط · هجوم',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    Text(
                      'عضو من مارس ٢٠٢٦',
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'profile.edit'.tr(context: context),
                type: CustomButtonType.outline,
                borderColor: AppColors.white,
                foregroundColor: AppColors.white,
                borderRadius: 10,
                height: 38.h,
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.profileSetup),
              ),
            ],
          ),
          hSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileStatWidget(
                value: '٢٢',
                label: 'profile.matches'.tr(context: context),
              ),
              ProfileStatWidget(
                value: '٦٤٪',
                label: 'profile.wins'.tr(context: context),
              ),
              ProfileStatWidget(
                value: '١٨',
                label: 'profile.bookings'.tr(context: context),
              ),
              ProfileStatWidget(
                value: '٢',
                label: 'profile.teams'.tr(context: context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
