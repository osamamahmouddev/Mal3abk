import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../animations/favorite_heart_widget.dart';
import '../extensions/app_display_extensions.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../utils/media_url.dart';
import 'custom_card_widget.dart';
import 'offer_badge_widget.dart';
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
    this.oldPricePerHour,
    this.offerLabel,
    this.noPriceText,
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

  /// The price before a running offer, shown struck through.
  final String? oldPricePerHour;

  /// The running offer ("20% off · until 27 November").
  final String? offerLabel;

  /// Shown instead of the price when the venue has none yet.
  final String? noPriceText;

  @override
  Widget build(BuildContext context) {
    final cleanedPrice = pricePerHour
        .replaceAll('/ساعة', '')
        .replaceAll('/ ساعة', '')
        .replaceAll('/', '')
        .trim();
    final resolvedUrl = MediaUrl.resolve(imageUrl);

    return CustomCardWidget(
      onTap: onTap,
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  width: 88.r,
                  height: 88.r,
                  color: AppColors.pitchGreenLight,
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.navyShadow4,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: resolvedUrl != null && resolvedUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: resolvedUrl,
                          fit: BoxFit.cover,
                          memCacheWidth: 264,
                          placeholder: (_, _) => const PitchPlaceholderWidget(),
                          errorWidget: (_, _, _) =>
                              const PitchPlaceholderWidget(),
                        )
                      : const PitchPlaceholderWidget(),
                ),
              ),
              SizedBox(width: 14.w),
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
                    if (cleanedPrice.isEmpty)
                      Text(
                        noPriceText ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      )
                    else
                      Text.rich(
                        TextSpan(
                          text: cleanedPrice,
                          style: AppTextStyles.font16Bold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  ' ${'common.per_hour'.tr(context: context)}',
                              style: AppTextStyles.font13Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            if (oldPricePerHour case final old?
                                when old.isNotEmpty)
                              TextSpan(
                                text: '  $old',
                                style: AppTextStyles.font12Regular.copyWith(
                                  color: AppColors.textSecondary,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ),
                    if (offerLabel case final offer? when offer.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      OfferBadgeWidget(label: offer),
                    ],
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
                        child: FavoriteHeartWidget(
                          isFavorite: isFavorite,
                          size: 20.r,
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
