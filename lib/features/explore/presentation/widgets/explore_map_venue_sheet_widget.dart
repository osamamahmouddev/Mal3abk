import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/pitch_placeholder_widget.dart';
import '../../../../core/widgets/slot_chip_widget.dart';

class ExploreMapVenueSheetWidget extends StatelessWidget {
  const ExploreMapVenueSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void openPitchAndTime() =>
        Navigator.of(context).pushNamed(AppRoutes.pitchAndTime);

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyShadow18,
            offset: Offset(0, 6.h),
            blurRadius: 24.r,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 76.r,
                  height: 76.r,
                  color: AppColors.pitchGreenLight,
                  child: const PitchPlaceholderWidget(),
                ),
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'explore.sample1_name'.tr(context: context),
                            style: AppTextStyles.font16Bold,
                          ),
                        ),
                        Text(
                          '★ ${'explore.sample1_rating'.tr(context: context)}',
                          style: AppTextStyles.font13Bold.copyWith(
                            color: AppColors.goldDark,
                          ),
                        ),
                      ],
                    ),
                    hSpace(6),
                    Text(
                      'explore.fav1_meta'.tr(context: context),
                      style: AppTextStyles.font12Regular,
                    ),
                    hSpace(2),
                    Text(
                      'explore.price_from_per_hour'.tr(
                        context: context,
                        args: ['١٥٠'],
                      ),
                      style: AppTextStyles.font14Bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSpace(12),
          Wrap(
            spacing: 6.w,
            children: [
              for (final key in const ['slot_8pm', 'slot_11pm', 'slot_12am'])
                SlotChipWidget(
                  label: 'explore.$key'.tr(context: context),
                  onTap: openPitchAndTime,
                ),
            ],
          ),
          hSpace(12),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'explore.view_venue'.tr(context: context),
                  height: 46.h,
                  borderRadius: 10,
                  boxShadow: AppShadows.redGlow,
                  textStyle: AppTextStyles.font15Bold.copyWith(
                    color: AppColors.white,
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                ),
              ),
              vSpace(8),
              CustomButton(
                text: '',
                type: CustomButtonType.outline,
                width: 46.r,
                height: 46.r,
                borderRadius: 10,
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.white,
                borderColor: AppColors.redBorder,
                icon: SvgPicture.asset(
                  AppAssets.icHeartFilled,
                  width: 20.r,
                  height: 20.r,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
