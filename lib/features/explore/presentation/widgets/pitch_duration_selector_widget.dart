import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';

class PitchDurationSelectorWidget extends StatelessWidget {
  const PitchDurationSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: SelectableTileWidget(
                title: 'explore.slots.one_hour'.tr(context: context),
                isSelected: true,
                onTap: () {},
                height: 46,
                borderRadius: 12,
              ),
            ),
            vSpace(8),
            Expanded(
              child: Container(
                height: 46.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'explore.slots.two_hours'.tr(context: context),
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
              ),
            ),
          ],
        ),
        hSpace(6),
        Text(
          'explore.slots.two_hours_unavailable'.tr(context: context),
          style: AppTextStyles.font12Regular,
        ),
      ],
    );
  }
}
