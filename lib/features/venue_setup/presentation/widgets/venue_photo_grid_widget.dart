import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/media_url.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/image_source_sheet_widget.dart';

/// Thumbnails with a remove button and an add tile that picks a photo.
class VenuePhotoGridWidget extends StatelessWidget {
  const VenuePhotoGridWidget({
    required this.photos,
    required this.onAdd,
    required this.onRemove,
    required this.busy,
    super.key,
  });

  final List<String> photos;
  final ValueChanged<Uint8List> onAdd;
  final ValueChanged<String> onRemove;
  final bool busy;

  Future<void> _pick(BuildContext context) async {
    final choice = await ImageSourceSheetWidget.show(
      context,
      title: 'venue.setup.photos.pick_title'.tr(context: context),
      subtitle: 'venue.setup.photos.pick_subtitle'.tr(context: context),
    );
    if (choice == null || choice == ImageSourceChoice.remove) return;
    try {
      final file = await ImagePicker().pickImage(
        source: choice == ImageSourceChoice.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        requestFullMetadata: false,
      );
      if (file == null) return;
      onAdd(await file.readAsBytes());
    } on PlatformException catch (_) {
      if (context.mounted) {
        AppTopSnackBar.showError(
          context,
          'errors.unknown'.tr(context: context),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = 92.r;
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (final photo in photos)
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: MediaUrl.resolve(photo) ?? '',
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) =>
                        const ColoredBox(color: AppColors.lightSurfaceDeep),
                  ),
                ),
                PositionedDirectional(
                  top: 4,
                  end: 4,
                  child: Material(
                    color: AppColors.black.withValues(alpha: 0.55),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: busy ? null : () => onRemove(photo),
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Icon(
                          Icons.close_rounded,
                          size: 16.r,
                          color: AppColors.white,
                          semanticLabel: 'venue.setup.photos.remove'.tr(
                            context: context,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        InkWell(
          onTap: busy ? null : () => _pick(context),
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.tableHead,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderInput),
            ),
            child: busy
                ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        color: AppColors.textSecondary,
                        size: 24.r,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'venue.setup.photos.add'.tr(context: context),
                        style: AppTextStyles.font11Bold.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
