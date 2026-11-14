import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/media_url.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../screens/photo_gallery_screen.dart';

class VenuePitchOptionCardWidget extends StatelessWidget {
  const VenuePitchOptionCardWidget({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onTap,
    this.photos = const [],
    super.key,
  });

  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onTap;
  final List<String> photos;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final baseUrl = sl<EnvConfig>().baseUrl;
    final resolvedPhotos = [
      for (final p in photos) MediaUrl.resolve(p, baseUrl: baseUrl) ?? p,
    ];
    final hasPhotos = resolvedPhotos.isNotEmpty;

    return CustomCardWidget(
      onTap: onTap,
      borderRadius: 18,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // صور أرضية الملعب (Pitch photo thumbnail)
          GestureDetector(
            onTap: hasPhotos
                ? () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.photoGallery,
                      arguments: PhotoGalleryArgs(
                        photos: resolvedPhotos,
                        initialIndex: 0,
                      ),
                    );
                  }
                : onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: SizedBox(
                width: 60.w,
                height: 60.h,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (hasPhotos)
                      CachedNetworkImage(
                        imageUrl: resolvedPhotos.first,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => Image.asset(
                          AppAssets.pitchPhoto,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Image.asset(AppAssets.pitchPhoto, fit: BoxFit.cover),
                    if (resolvedPhotos.length > 1)
                      Positioned(
                        bottom: 3.h,
                        right: 3.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xAA000000),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            resolvedPhotos.length.toLocalizedDigits(lang),
                            style: AppTextStyles.font10Regular.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.font15Bold),
                hSpace(4),
                Text(
                  subtitle,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (hasPhotos) ...[
                  hSpace(3),
                  Text(
                    'explore.venue.pitch_photos_count'.tr(
                      context: context,
                      args: [resolvedPhotos.length.toLocalizedDigits(lang)],
                    ),
                    style: AppTextStyles.font11Bold.copyWith(
                      color: AppColors.brandRed,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (price.isNotEmpty)
            Text.rich(
              TextSpan(
                text: price,
                style: AppTextStyles.font15Bold,
                children: [
                  TextSpan(
                    text: 'explore.venue.per_hour_short'.tr(context: context),
                    style: AppTextStyles.font12Medium,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
