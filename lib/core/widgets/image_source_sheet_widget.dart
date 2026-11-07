import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'image_source_option_widget.dart';

/// What the player chose in [ImageSourceSheetWidget].
enum ImageSourceChoice { gallery, camera, remove }

/// Bottom sheet for adding a photo: gallery or camera side by side, and
/// optionally removing the current one.
class ImageSourceSheetWidget extends StatelessWidget {
  const ImageSourceSheetWidget({
    required this.title,
    required this.subtitle,
    this.removeLabel,
    super.key,
  });

  final String title;
  final String subtitle;

  /// Shown as a destructive action when there is a photo to remove.
  final String? removeLabel;

  static Future<ImageSourceChoice?> show(
    BuildContext context, {
    required String title,
    required String subtitle,
    String? removeLabel,
  }) {
    HapticFeedback.selectionClick();
    return showModalBottomSheet<ImageSourceChoice>(
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (_) => ImageSourceSheetWidget(
        title: title,
        subtitle: subtitle,
        removeLabel: removeLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void choose(ImageSourceChoice choice) => Navigator.of(context).pop(choice);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderInput,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              hSpace(20),
              Text(title, style: AppTextStyles.font18Bold),
              hSpace(6),
              Text(
                subtitle,
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(20),
              Row(
                children: [
                  Expanded(
                    child: ImageSourceOptionWidget(
                      icon: Icons.photo_library_rounded,
                      label: 'common.image_source.gallery'.tr(context: context),
                      hint: 'common.image_source.gallery_hint'.tr(
                        context: context,
                      ),
                      iconColor: AppColors.brandNavy,
                      iconBackground: AppColors.lightSurface,
                      onTap: () => choose(ImageSourceChoice.gallery),
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: ImageSourceOptionWidget(
                      icon: Icons.photo_camera_rounded,
                      label: 'common.image_source.camera'.tr(context: context),
                      hint: 'common.image_source.camera_hint'.tr(
                        context: context,
                      ),
                      iconColor: AppColors.brandRed,
                      iconBackground: AppColors.redLight,
                      onTap: () => choose(ImageSourceChoice.camera),
                    ),
                  ),
                ],
              ),
              if (removeLabel != null) ...[
                hSpace(12),
                TextButton.icon(
                  onPressed: () => choose(ImageSourceChoice.remove),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.redText,
                    backgroundColor: AppColors.redLight,
                    minimumSize: Size.fromHeight(48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    textStyle: AppTextStyles.font14SemiBold,
                  ),
                  icon: Icon(Icons.delete_outline_rounded, size: 20.r),
                  label: Text(removeLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
