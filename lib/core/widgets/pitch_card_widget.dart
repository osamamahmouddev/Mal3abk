import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../extensions/app_display_extensions.dart';
import '../styles/app_assets.dart';
import '../styles/app_colors.dart';
import '../styles/app_motion.dart';
import '../styles/app_text_styles.dart';
import 'custom_card_widget.dart';
import 'pitch_placeholder_widget.dart';
import 'slot_chip_widget.dart';

class PitchCardWidget extends StatelessWidget {
  const PitchCardWidget({
    required this.name,
    required this.specs,
    required this.pricePerHour,
    super.key,
    this.rating,
    this.imageUrl,
    this.availableSlots = const [],
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onTap,
    this.onSlotTap,
  });

  final String name;
  final String specs;
  final String pricePerHour;
  final String? rating;
  final String? imageUrl;
  final List<String> availableSlots;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSlotTap;

  @override
  Widget build(BuildContext context) {
    final cleanedPrice = pricePerHour
        .replaceAll('/ساعة', '')
        .replaceAll('/ ساعة', '')
        .replaceAll('/', '')
        .trim();

    return CustomCardWidget(
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  width: 72.r,
                  height: 72.r,
                  color: AppColors.pitchGreenLight,
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          memCacheWidth: 228,
                          placeholder: (_, _) => const PitchPlaceholderWidget(),
                          errorWidget: (_, _, _) =>
                              const PitchPlaceholderWidget(),
                        )
                      : const PitchPlaceholderWidget(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      specs,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Text.rich(
                      TextSpan(
                        text: cleanedPrice,
                        style: AppTextStyles.font16Bold.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${'common.per_hour'.tr(context: context)}',
                            style: AppTextStyles.font13Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (rating != null && rating!.isNotEmpty) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '★',
                          style: AppTextStyles.font12Bold.copyWith(
                            color: AppColors.goldDark,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          rating!.toArabicDigits(),
                          style: AppTextStyles.font13Bold.copyWith(
                            color: AppColors.goldDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],
                  if (onFavoriteTap != null)
                    InkWell(
                      onTap: onFavoriteTap,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: AnimatedSwitcher(
                          duration: AppMotion.medium,
                          switchInCurve: AppMotion.emphasized,
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: SvgPicture.asset(
                            isFavorite
                                ? AppAssets.icHeartFilled
                                : AppAssets.icHeartOutline,
                            key: ValueKey(isFavorite),
                            width: 20.r,
                            height: 20.r,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (availableSlots.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                for (final slot in availableSlots)
                  SlotChipWidget(
                    label: slot.toArabicDigits(),
                    onTap: () => onSlotTap?.call(slot),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
