import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_shadows.dart';
import '../styles/app_text_styles.dart';
import 'app_badge_widget.dart';
import 'custom_button.dart';
import 'custom_card_widget.dart';
import 'venue_thumbnail_widget.dart';

enum BookingCardTone {
  confirmed,
  pendingReview,
  rejected,
  completed,
  cancelled,
}

class BookingCardWidget extends StatelessWidget {
  const BookingCardWidget({
    required this.venueName,
    required this.pitchName,
    required this.dateTime,
    required this.bookingCode,
    required this.status,
    required this.statusText,
    super.key,
    this.depositRowText,
    this.depositAmount,
    this.imageUrl,
    this.noteText,
    this.primaryActionText,
    this.secondaryActionText,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.onTap,
  });

  final String venueName;
  final String pitchName;
  final String dateTime;
  final String bookingCode;
  final BookingCardTone status;
  final String statusText;
  final String? depositRowText;
  final String? depositAmount;
  final String? imageUrl;
  final String? noteText;
  final String? primaryActionText;
  final String? secondaryActionText;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    AppBadgeType badgeType;
    Color noteBg = AppColors.lightGrayBackground;
    Color noteFg = AppColors.textPrimary;

    switch (status) {
      case BookingCardTone.confirmed:
        badgeType = AppBadgeType.success;
        noteBg = AppColors.successLight;
        noteFg = AppColors.successGreen;
        break;
      case BookingCardTone.pendingReview:
        badgeType = AppBadgeType.warning;
        noteBg = AppColors.goldLight;
        noteFg = AppColors.goldDark;
        break;
      case BookingCardTone.rejected:
        badgeType = AppBadgeType.error;
        noteBg = AppColors.redLight;
        noteFg = AppColors.redText;
        break;
      case BookingCardTone.completed:
        badgeType = AppBadgeType.neutral;
        break;
      case BookingCardTone.cancelled:
        badgeType = AppBadgeType.neutral;
        break;
    }

    return CustomCardWidget(
      onTap: onTap,
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VenueThumbnailWidget(imageUrl: imageUrl, size: 56),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$venueName — $pitchName',
                      style: AppTextStyles.font15Bold,
                    ),
                    hSpace(4),
                    Text(dateTime, style: AppTextStyles.font13Regular),
                    hSpace(2),
                    Text(
                      bookingCode,
                      textDirection: TextDirection.ltr,
                      style: AppTextStyles.font12Regular,
                    ),
                  ],
                ),
              ),
              vSpace(8),
              AppBadgeWidget(
                text: statusText,
                type: badgeType,
                borderRadius: 13,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              ),
            ],
          ),
          if (depositRowText != null && depositAmount != null) ...[
            hSpace(16),
            Container(
              height: 39.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.lightGrayBackground,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Text(depositRowText!, style: AppTextStyles.font13Regular),
                  const Spacer(),
                  Text(depositAmount!, style: AppTextStyles.font13SemiBold),
                ],
              ),
            ),
          ],
          if (noteText != null) ...[
            hSpace(12),
            Container(
              constraints: BoxConstraints(minHeight: 40.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                color: noteBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                noteText!,
                style: AppTextStyles.font13Regular.copyWith(color: noteFg),
              ),
            ),
          ],
          if (primaryActionText != null || secondaryActionText != null) ...[
            hSpace(12),
            Row(
              children: [
                if (primaryActionText != null)
                  Expanded(
                    child: CustomButton(
                      text: primaryActionText!,
                      onTap: onPrimaryAction ?? () {},
                      height: 46.h,
                      borderRadius: 10,
                      boxShadow: AppShadows.redGlow,
                      textStyle: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                if (primaryActionText != null && secondaryActionText != null)
                  vSpace(8),
                if (secondaryActionText != null)
                  Expanded(
                    child: CustomButton(
                      text: secondaryActionText!,
                      onTap: onSecondaryAction ?? () {},
                      type: CustomButtonType.outline,
                      height: 46.h,
                      borderRadius: 10,
                      textStyle: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.brandNavy,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
