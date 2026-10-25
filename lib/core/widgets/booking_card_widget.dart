import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'app_badge_widget.dart';
import 'custom_button.dart';
import 'custom_card_widget.dart';

enum BookingStatus {
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
  final BookingStatus status;
  final String statusText;
  final String? depositRowText;
  final String? depositAmount;
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
      case BookingStatus.confirmed:
        badgeType = AppBadgeType.success;
        noteBg = AppColors.successLight;
        noteFg = AppColors.successGreen;
        break;
      case BookingStatus.pendingReview:
        badgeType = AppBadgeType.warning;
        noteBg = AppColors.goldLight;
        noteFg = AppColors.goldDark;
        break;
      case BookingStatus.rejected:
        badgeType = AppBadgeType.error;
        noteBg = AppColors.redLight;
        noteFg = AppColors.redText;
        break;
      case BookingStatus.completed:
        badgeType = AppBadgeType.neutral;
        break;
      case BookingStatus.cancelled:
        badgeType = AppBadgeType.neutral;
        break;
    }

    return CustomCardWidget(
      onTap: onTap,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54.w,
                height: 54.h,
                decoration: BoxDecoration(
                  color: AppColors.pitchGreen,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.sports_soccer_rounded,
                    color: AppColors.white,
                    size: 26.sp,
                  ),
                ),
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$venueName — $pitchName',
                      style: AppTextStyles.font15Bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    hSpace(4),
                    Text(
                      dateTime,
                      style: AppTextStyles.font13Regular,
                    ),
                    hSpace(4),
                    Text(
                      bookingCode,
                      style: AppTextStyles.font12Medium,
                    ),
                  ],
                ),
              ),
              AppBadgeWidget(
                text: statusText,
                type: badgeType,
              ),
            ],
          ),
          if (depositRowText != null && depositAmount != null) ...[
            hSpace(12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.lightGrayBackground,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    depositRowText!,
                    style: AppTextStyles.font13Regular,
                  ),
                  Text(
                    depositAmount!,
                    style: AppTextStyles.font13SemiBold,
                  ),
                ],
              ),
            ),
          ],
          if (noteText != null) ...[
            hSpace(8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
            hSpace(14),
            Row(
              children: [
                if (secondaryActionText != null)
                  Expanded(
                    child: CustomButton(
                      text: secondaryActionText!,
                      onTap: onSecondaryAction ?? () {},
                      type: CustomButtonType.outline,
                      height: 44.h,
                    ),
                  ),
                if (primaryActionText != null && secondaryActionText != null)
                  vSpace(10),
                if (primaryActionText != null)
                  Expanded(
                    child: CustomButton(
                      text: primaryActionText!,
                      onTap: onPrimaryAction ?? () {},
                      type: status == BookingStatus.rejected
                          ? CustomButtonType.primary
                          : CustomButtonType.secondary,
                      height: 44.h,
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

