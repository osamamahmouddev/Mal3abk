import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/theme/app_system_ui.dart';
import '../widgets/photo_gallery_thumbnails_widget.dart';
import '../widgets/venue_hero_button_widget.dart';
import '../widgets/zoomable_photo_widget.dart';

/// The photos to show full screen and the one to open on.
class PhotoGalleryArgs {
  const PhotoGalleryArgs({required this.photos, this.initialIndex = 0});

  final List<String> photos;
  final int initialIndex;
}

/// Full-screen photos: swipe between them, pinch or double-tap to zoom.
/// Pops with the index of the photo last shown.
class PhotoGalleryScreen extends HookWidget {
  const PhotoGalleryScreen({required this.args, super.key});

  final PhotoGalleryArgs args;

  @override
  Widget build(BuildContext context) {
    final photos = args.photos;
    final initial = args.initialIndex.clamp(0, photos.length - 1);
    final controller = usePageController(initialPage: initial);
    final page = useState(initial);
    final isZoomed = useState(false);

    void close() => Navigator.of(context).pop(page.value);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) close();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.onDark,
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: Stack(
            children: [
              PageView.builder(
                controller: controller,
                physics: isZoomed.value
                    ? const NeverScrollableScrollPhysics()
                    : const PageScrollPhysics(),
                itemCount: photos.length,
                onPageChanged: (index) {
                  page.value = index;
                  isZoomed.value = false;
                },
                itemBuilder: (_, index) => ZoomablePhotoWidget(
                  url: photos[index],
                  onZoomChanged: (zoomed) => isZoomed.value = zoomed,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                  child: Row(
                    children: [
                      VenueHeroButtonWidget(
                        iconAsset: AppAssets.icClose,
                        onTap: close,
                      ),
                      const Spacer(),
                      Text(
                        '${page.value + 1} / ${photos.length}',
                        style: AppTextStyles.font14SemiBold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (photos.length > 1)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: PhotoGalleryThumbnailsWidget(
                        photos: photos,
                        selectedIndex: page.value,
                        onSelected: (index) => controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
