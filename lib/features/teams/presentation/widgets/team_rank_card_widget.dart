import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/media_url.dart';

/// One standings row: rank, team + trend, W-D-L record and points.
class TeamRankCardWidget extends StatelessWidget {
  const TeamRankCardWidget({
    required this.rank,
    required this.teamName,
    required this.trend,
    required this.record,
    required this.points,
    super.key,
    this.initials = '',
    this.logoUrl,
    this.isMyTeam = false,
  });

  final String rank;
  final String teamName;
  final String trend;
  final String record;
  final String points;
  final String initials;
  final String? logoUrl;
  final bool isMyTeam;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: isMyTeam ? AppColors.goldLight : null,
        border: const Border(top: BorderSide(color: AppColors.lightSurface)),
      ),
      child: Row(
        children: [
          Container(
            width: 30.w,
            alignment: AlignmentDirectional.centerStart,
            child: Text(rank, style: AppTextStyles.font14Bold),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: [
                _TeamAvatar(initials: initials, logoUrl: logoUrl),
                vSpace(8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teamName,
                        style: AppTextStyles.font14Bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      hSpace(2),
                      Text(
                        trend,
                        style: AppTextStyles.font11Regular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              record,
              textAlign: TextAlign.center,
              style: AppTextStyles.font12Regular.copyWith(
                color: AppColors.textBody,
              ),
            ),
          ),
          Container(
            width: 32.w,
            alignment: AlignmentDirectional.centerEnd,
            child: Text(points, style: AppTextStyles.font14Bold),
          ),
        ],
      ),
    );
  }
}

class _TeamAvatar extends StatelessWidget {
  const _TeamAvatar({required this.initials, this.logoUrl});

  final String initials;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    final resolvedLogo = MediaUrl.resolve(logoUrl);
    const size = 32.0;
    final placeholder = Text(
      initials,
      style: AppTextStyles.font11Bold.copyWith(color: AppColors.brandNavy),
    );

    return Container(
      width: size.r,
      height: size.r,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        shape: BoxShape.circle,
      ),
      child: resolvedLogo == null || resolvedLogo.isEmpty
          ? placeholder
          : CachedNetworkImage(
              imageUrl: resolvedLogo,
              fit: BoxFit.cover,
              memCacheWidth: (size * 2).round(),
              errorWidget: (_, _, _) => placeholder,
            ),
    );
  }
}
