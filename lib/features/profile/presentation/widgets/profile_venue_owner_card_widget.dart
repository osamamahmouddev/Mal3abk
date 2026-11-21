import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class ProfileVenueOwnerCardWidget extends StatelessWidget {
  const ProfileVenueOwnerCardWidget({super.key});

  static final Uri _venueOwnerUri = Uri.parse(
    'https://mal3abk-venue.vercel.app/venue/overview',
  );

  Future<void> _openVenueOwnerSite() async {
    await launchUrl(_venueOwnerUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      padding: EdgeInsets.zero,
      borderColor: AppColors.goldBorder,
      onTap: _openVenueOwnerSite,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.goldLight, AppColors.white],
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.accentGold,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                Icons.stadium_rounded,
                size: 26.sp,
                color: AppColors.white,
              ),
            ),
            hSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'profile.venue_owner_title'.tr(context: context),
                    style: AppTextStyles.font14Bold.copyWith(
                      color: AppColors.goldDark,
                    ),
                  ),
                  vSpace(2),
                  Text(
                    'profile.venue_owner_sub'.tr(context: context),
                    style: AppTextStyles.font11Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            hSpace(8),
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.goldBorder),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12.sp,
                color: AppColors.goldDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
