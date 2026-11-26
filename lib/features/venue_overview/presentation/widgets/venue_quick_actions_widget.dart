import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class VenueQuickActionsWidget extends StatelessWidget {
  const VenueQuickActionsWidget({
    required this.onBlockSlot,
    required this.onManualBooking,
    super.key,
  });

  final VoidCallback onBlockSlot;
  final VoidCallback onManualBooking;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'venue.overview.block_slot'.tr(context: context),
            type: CustomButtonType.outline,
            height: 46.h,
            borderRadius: 12,
            icon: Icon(Icons.block_rounded, size: 18.r),
            onTap: onBlockSlot,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomButton(
            text: 'venue.overview.manual_booking'.tr(context: context),
            height: 46.h,
            borderRadius: 12,
            icon: Icon(Icons.add_rounded, size: 18.r, color: AppColors.white),
            textStyle: AppTextStyles.font14Bold.copyWith(
              color: AppColors.white,
            ),
            onTap: onManualBooking,
          ),
        ),
      ],
    );
  }
}
