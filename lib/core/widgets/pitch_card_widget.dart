import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_card_widget.dart';

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
  final double? rating;
  final String? imageUrl;
  final List<String> availableSlots;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSlotTap;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: onTap,
      padding: EdgeInsets.all(14.w),
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: SizedBox(
                  width: 76.w,
                  height: 76.h,
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.lightSurface,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => _buildPlaceholderPitch(),
                        )
                      : _buildPlaceholderPitch(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: AppTextStyles.font15Bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (onFavoriteTap != null)
                          GestureDetector(
                            onTap: onFavoriteTap,
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 22.sp,
                              color: isFavorite
                                  ? AppColors.brandRed
                                  : AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    if (rating != null) ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 16.sp,
                            color: AppColors.goldDark,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            rating!.toStringAsFixed(1),
                            style: AppTextStyles.font12Bold.copyWith(
                              color: AppColors.goldDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: 4.h),
                    Text(
                      specs,
                      style: AppTextStyles.font12Regular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          pricePerHour,
                          style: AppTextStyles.font15Bold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '/ ساعة',
                          style: AppTextStyles.font12Medium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (availableSlots.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 6.h,
              children: availableSlots.map((slot) {
                return InkWell(
                  onTap: () => onSlotTap?.call(slot),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.successLight,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      slot,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: AppColors.successGreen,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlaceholderPitch() {
    return Container(
      color: AppColors.pitchGreen,
      child: Center(
        child: Icon(
          Icons.sports_soccer_rounded,
          size: 32.sp,
          color: AppColors.white.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}

