import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/split_flap_text_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';

class TeamMatchupHeaderWidget extends StatelessWidget {
  const TeamMatchupHeaderWidget({
    required this.homeName,
    required this.awayName,
    required this.center,
    super.key,
    this.homeCaption,
    this.awayCaption,
    this.score,
  });

  final String homeName;
  final String awayName;

  /// Shown between the teams when there is no [score] ("vs").
  final String center;
  final String? homeCaption;
  final String? awayCaption;

  /// Home and away goals, already in the player's digits: shown on a
  /// split-flap board that flips in, home first.
  final (String, String)? score;

  @override
  Widget build(BuildContext context) {
    Widget side(String name, String? caption, Color color) => Expanded(
      child: Column(
        children: [
          InitialsAvatarWidget(initials: name.initials, color: color, size: 52),
          hSpace(8),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font14Bold.copyWith(color: AppColors.white),
          ),
          if (caption != null) ...[
            hSpace(2),
            Text(
              caption,
              textAlign: TextAlign.center,
              style: AppTextStyles.font11Regular.copyWith(
                color: AppColors.onNavyMuted,
              ),
            ),
          ],
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          side(homeName, homeCaption, AppColors.brandPrimaryLight),
          Padding(
            padding: EdgeInsets.only(top: 14.h),
            child: switch (score) {
              (final home, final away) => Row(
                mainAxisSize: MainAxisSize.min,
                // Same order as the teams around it: home first.
                children: [
                  _flap(home),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Text(
                      '–',
                      style: AppTextStyles.font18Bold.copyWith(
                        color: AppColors.accentGold,
                      ),
                    ),
                  ),
                  _flap(away, delay: const Duration(milliseconds: 140)),
                ],
              ),
              null => Text(
                center,
                style: AppTextStyles.font18Bold.copyWith(
                  color: AppColors.accentGold,
                ),
              ),
            },
          ),
          side(awayName, awayCaption, AppColors.brandRed),
        ],
      ),
    );
  }

  Widget _flap(String goals, {Duration delay = Duration.zero}) =>
      SplitFlapTextWidget(
        text: goals,
        delay: delay,
        tileColor: AppColors.brandPrimaryDark,
        radius: 8.r,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        style: AppTextStyles.font18Bold.copyWith(color: AppColors.accentGold),
      );
}
