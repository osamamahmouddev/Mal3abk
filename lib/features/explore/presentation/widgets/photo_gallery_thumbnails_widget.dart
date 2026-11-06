import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// Strip of small photos under the gallery; tapping one jumps to it.
class PhotoGalleryThumbnailsWidget extends StatelessWidget {
  const PhotoGalleryThumbnailsWidget({
    required this.photos,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<String> photos;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.r,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: photos.length,
        separatorBuilder: (_, _) => vSpace(8),
        itemBuilder: (_, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isSelected ? AppColors.white : AppColors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSelected ? 1 : 0.5,
                  child: CachedNetworkImage(
                    imageUrl: photos[index],
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) =>
                        const ColoredBox(color: AppColors.white10),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
