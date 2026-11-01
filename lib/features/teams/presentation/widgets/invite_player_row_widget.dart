import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';

enum InvitePlayerStatus { available, sent, member }

class InvitePlayerRowWidget extends StatelessWidget {
  const InvitePlayerRowWidget({
    required this.initials,
    required this.name,
    required this.meta,
    required this.status,
    required this.onInvite,
    super.key,
  });

  final String initials;
  final String name;
  final String meta;
  final InvitePlayerStatus status;
  final VoidCallback onInvite;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg, border) = switch (status) {
      InvitePlayerStatus.sent => (
        'teams.invite.sent',
        AppColors.successLight,
        AppColors.successGreen,
        AppColors.successBorderSoft,
      ),
      InvitePlayerStatus.member => (
        'teams.invite.in_team',
        AppColors.lightSurface,
        AppColors.textSecondary,
        null,
      ),
      InvitePlayerStatus.available => (
        'teams.invite.invite',
        AppColors.brandRed,
        AppColors.white,
        null,
      ),
    };

    return Container(
      height: 85.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lightSurface)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.lightSurface,
              shape: BoxShape.circle,
            ),
            child: Text(
              initials,
              style: AppTextStyles.font14Bold.copyWith(
                color: AppColors.brandNavy,
              ),
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.font14Bold),
                hSpace(4),
                Text(meta, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          GestureDetector(
            onTap: status == InvitePlayerStatus.available ? onInvite : null,
            child: Container(
              constraints: BoxConstraints(minWidth: 92.w),
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(10.r),
                border: border == null ? null : Border.all(color: border),
                boxShadow: status == InvitePlayerStatus.available
                    ? AppShadows.redGlow
                    : null,
              ),
              child: Text(
                label.tr(context: context),
                style: AppTextStyles.font13Bold.copyWith(color: fg),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
