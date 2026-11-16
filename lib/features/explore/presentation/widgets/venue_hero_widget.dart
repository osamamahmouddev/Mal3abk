import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/animations/double_tap_heart_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/media_url.dart';
import '../screens/photo_gallery_screen.dart';

/// Swipeable venue photos; tapping a photo opens it full screen. The back and
/// favourite buttons sit above it in `VenueHeroActionsWidget`.
class VenueHeroWidget extends HookWidget {
  const VenueHeroWidget({
    required this.venueId,
    required this.photos,
    this.onDoubleTapLike,
    super.key,
  });

  final String venueId;
  final List<String> photos;

  /// Double tapping a photo likes the venue (never un-likes it).
  final VoidCallback? onDoubleTapLike;

  @override
  Widget build(BuildContext context) {
    final page = useState(0);
    final controller = usePageController();
    final baseUrl = sl<EnvConfig>().baseUrl;
    final resolvedPhotos = [
      for (final p in photos) MediaUrl.resolve(p, baseUrl: baseUrl) ?? p,
    ];

    Future<void> openGallery(int index) async {
      final lastShown = await Navigator.of(context).pushNamed<int>(
        AppRoutes.photoGallery,
        arguments: PhotoGalleryArgs(
          photos: resolvedPhotos,
          initialIndex: index,
        ),
      );
      if (lastShown != null && controller.hasClients) {
        controller.jumpToPage(lastShown);
      }
    }

    final placeholder = SvgPicture.asset(
      AppAssets.pitchHero,
      fit: BoxFit.cover,
    );

    return SizedBox(
      height: 230.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: DoubleTapHeartWidget(
              onDoubleTap: () => onDoubleTapLike?.call(),
              child: Hero(
                tag: 'venue-$venueId',
                child: resolvedPhotos.isEmpty
                    ? placeholder
                    : PageView.builder(
                        controller: controller,
                        itemCount: resolvedPhotos.length,
                        onPageChanged: (index) => page.value = index,
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () => openGallery(index),
                          child: CachedNetworkImage(
                            imageUrl: resolvedPhotos[index],
                            fit: BoxFit.cover,
                            memCacheWidth: 1200,
                            placeholder: (_, _) => placeholder,
                            errorWidget: (_, _, _) => placeholder,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          if (resolvedPhotos.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 12.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < resolvedPhotos.length; i++) ...[
                    if (i > 0) vSpace(5),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: (i == page.value ? 18 : 6).w,
                      height: 6.r,
                      decoration: BoxDecoration(
                        color: i == page.value
                            ? AppColors.white
                            : AppColors.white60,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          if (resolvedPhotos.isNotEmpty)
            Positioned(
              bottom: 12.h,
              right: 14.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0x99000000),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'explore.venue.facility_photos_badge'.tr(context: context),
                  style: AppTextStyles.font10Regular.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
