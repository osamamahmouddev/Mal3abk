import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/theme/app_system_ui.dart';
import '../../../../core/widgets/custom_button.dart';
import 'profile_stat_widget.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  const ProfileHeaderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.onDark,
      child: Container(
        color: AppColors.brandNavy,
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                AppAssets.teamHeroPattern,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 20.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 36.r,
                          backgroundColor: AppColors.brandRed,
                          child: Text(
                            'أس',
                            style: AppTextStyles.font24Bold.copyWith(
                              color: AppColors.white,
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
                                style: AppTextStyles.font22Bold.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                'مدينة نصر · وسط · هجوم',
                                style: AppTextStyles.font13Regular.copyWith(
                                  color: AppColors.onNavyMuted,
                                ),
                              ),
                              Text(
                                'عضو من مارس ٢٠٢٦',
                                style: AppTextStyles.font12Regular.copyWith(
                                  color: AppColors.onNavySubtle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomButton(
                          text: 'profile.edit'.tr(context: context),
                          type: CustomButtonType.outline,
                          borderColor: AppColors.white35,
                          borderRadius: 10,
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          textStyle: AppTextStyles.font14SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                          onTap: () => Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.profileSetup),
                        ),
                      ],
                    ),
                    hSpace(16),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileStatWidget(
                            value: '٢٢',
                            label: 'profile.matches'.tr(context: context),
                          ),
                        ),
                        vSpace(8),
                        Expanded(
                          child: ProfileStatWidget(
                            value: '٦٤٪',
                            label: 'profile.wins'.tr(context: context),
                          ),
                        ),
                        vSpace(8),
                        Expanded(
                          child: ProfileStatWidget(
                            value: '١٨',
                            label: 'profile.bookings'.tr(context: context),
                          ),
                        ),
                        vSpace(8),
                        Expanded(
                          child: ProfileStatWidget(
                            value: '٢',
                            label: 'profile.teams'.tr(context: context),
                            valueColor: AppColors.accentGold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
