import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_spaces.dart';
import '../styles/app_assets.dart';
import '../styles/app_colors.dart';
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
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 76.r,
                  height: 76.r,
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
              vSpace(12),
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
                        if (rating != null)
                          Text(
                            '★ ${rating!}',
                            style: AppTextStyles.font12Bold.copyWith(
                              color: AppColors.goldDark,
                            ),
                          ),
                      ],
                    ),
                    hSpace(6),
                    Text(
                      specs,
                      style: AppTextStyles.font12Regular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    hSpace(2),
                    Text.rich(
                      TextSpan(
                        text: pricePerHour,
                        style: AppTextStyles.font15Bold,
                        children: [
                          TextSpan(
                            text: ' ${'common.per_hour'.tr(context: context)}',
                            style: AppTextStyles.font12Medium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (onFavoriteTap != null)
                InkWell(
                  onTap: onFavoriteTap,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: SvgPicture.asset(
                      isFavorite ? AppAssets.icHeartFilled : AppAssets.icHeartOutline,
                      width: 20.r,
                      height: 20.r,
                    ),
                  ),
                ),
            ],
          ),
          if (availableSlots.isNotEmpty) ...[
            hSpace(10),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: [
                for (final slot in availableSlots)
                  SlotChipWidget(
                    label: slot,
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
