import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../screens/photo_gallery_screen.dart';
import 'venue_hero_button_widget.dart';

/// Swipeable venue photos with back and favourite buttons; tapping a photo
/// opens it full screen.
class VenueHeroWidget extends HookWidget {
  const VenueHeroWidget({
    required this.venueId,
    required this.photos,
    required this.isFavorite,
    required this.onFavoriteTap,
    super.key,
  });

  final String venueId;
  final List<String> photos;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final page = useState(0);
    final controller = usePageController();

    Future<void> openGallery(int index) async {
      final lastShown = await Navigator.of(context).pushNamed<int>(
        AppRoutes.photoGallery,
        arguments: PhotoGalleryArgs(photos: photos, initialIndex: index),
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
            child: Hero(
              tag: 'venue-$venueId',
              child: photos.isEmpty
                  ? placeholder
                  : PageView.builder(
                      controller: controller,
                      itemCount: photos.length,
                      onPageChanged: (index) => page.value = index,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () => openGallery(index),
                        child: CachedNetworkImage(
                          imageUrl: photos[index],
                          fit: BoxFit.cover,
                          placeholder: (_, _) => placeholder,
                          errorWidget: (_, _, _) => placeholder,
                        ),
                      ),
                    ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VenueHeroButtonWidget(
                    iconAsset: AppAssets.icArrowBack20,
                    mirrorInLtr: true,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  VenueHeroButtonWidget(
                    iconAsset: isFavorite
                        ? AppAssets.icHeartFilled
                        : AppAssets.icHeartOutline,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onFavoriteTap();
                    },
                  ),
                ],
              ),
            ),
          ),
          if (photos.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 12.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < photos.length; i++) ...[
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
        ],
      ),
    );
  }
}
