import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/media_url.dart';

class HomeNearbyPitchCardWidget extends StatelessWidget {
  const HomeNearbyPitchCardWidget({
    required this.name,
    required this.price,
    required this.dist,
    required this.slot,
    required this.onTap,
    this.imageUrl,
    this.isAvailableNow = false,
    super.key,
  });

  final String name;
  final String price;
  final String dist;
  final String slot;
  final VoidCallback onTap;

  /// Whether the venue has a free slot starting within the hour: shown as a
  /// live badge on the photo instead of buried in the text below.
  final bool isAvailableNow;

  /// The venue's cover photo; the built-in pattern shows until it loads, or
  /// when the venue has none.
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20.r);
    final placeholder = SvgPicture.asset(
      AppAssets.pitchThumbWide,
      height: 96.h,
      fit: BoxFit.cover,
    );
    final resolvedUrl = MediaUrl.resolve(imageUrl);

    return Container(
      width: 222.w,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: AppShadows.card,
      ),
      child: Material(
        color: AppColors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: const BorderSide(color: AppColors.borderCard),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 96.h,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    resolvedUrl == null || resolvedUrl.isEmpty
                        ? placeholder
                        : CachedNetworkImage(
                            imageUrl: resolvedUrl,
                            fit: BoxFit.cover,
                            memCacheWidth: 700,
                            placeholder: (_, _) => placeholder,
                            errorWidget: (_, _, _) => placeholder,
                          ),
                    if (isAvailableNow)
                      PositionedDirectional(
                        top: 8.h,
                        start: 8.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.successGreen,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6.r,
                                height: 6.r,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              vSpace(5),
                              Text(
                                'home.available_now'.tr(context: context),
                                style: AppTextStyles.font11Regular.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: AppTextStyles.font14Bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (price.isNotEmpty)
                          Text(
                            price,
                            style: AppTextStyles.font12Bold.copyWith(
                              color: AppColors.goldDark,
                            ),
                          ),
                      ],
                    ),
                    hSpace(4),
                    Text(dist, style: AppTextStyles.font12Regular),
                    hSpace(4),
                    Text(
                      slot,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: AppColors.successGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
