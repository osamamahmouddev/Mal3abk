import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ProfileAvatarPickerWidget extends StatelessWidget {
  const ProfileAvatarPickerWidget({
    required this.initials,
    required this.onTap,
    super.key,
    this.avatarUrl,
    this.isUploading = false,
  });

  final String initials;
  final String? avatarUrl;
  final bool isUploading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = 76.r;
    final fallback = Text(
      initials,
      style: AppTextStyles.font26Bold.copyWith(color: AppColors.white),
    );
    return InkWell(
      onTap: isUploading ? null : onTap,
      borderRadius: BorderRadius.circular(38.r),
      child: Row(
        children: [
          Hero(
            tag: 'my-avatar',
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: AppColors.brandNavy,
                shape: BoxShape.circle,
              ),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  if (avatarUrl case final url?)
                    CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      memCacheWidth: 228,
                      errorWidget: (_, _, _) => Center(child: fallback),
                    )
                  else
                    Center(child: fallback),
                  if (isUploading)
                    const ColoredBox(
                      color: AppColors.navyShadow30,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation(AppColors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          vSpace(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'onboarding.profile_setup.avatar_title'.tr(context: context),
                  style: AppTextStyles.font15Bold,
                ),
                hSpace(4),
                Text(
                  'onboarding.profile_setup.avatar_sub'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
