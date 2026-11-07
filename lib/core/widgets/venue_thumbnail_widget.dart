import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/app_assets.dart';

/// A small square of the venue's cover photo. The built-in pitch pattern
/// shows until the photo loads, if it fails, or when the venue has none.
class VenueThumbnailWidget extends StatelessWidget {
  const VenueThumbnailWidget({
    required this.size,
    this.imageUrl,
    this.borderRadius = 12,
    super.key,
  });

  final String? imageUrl;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final placeholder = SvgPicture.asset(
      AppAssets.pitchThumbSquare,
      width: size.r,
      height: size.r,
      fit: BoxFit.cover,
    );
    final url = imageUrl;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: SizedBox.square(
        dimension: size.r,
        child: url == null || url.isEmpty
            ? placeholder
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                memCacheWidth: 240,
                placeholder: (_, _) => placeholder,
                errorWidget: (_, _, _) => placeholder,
              ),
      ),
    );
  }
}
