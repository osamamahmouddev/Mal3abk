import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../data/models/session_model.dart';

/// One signed-in device: what it is, when it was last used, and a way out.
class SessionTileWidget extends StatelessWidget {
  const SessionTileWidget({
    required this.session,
    required this.enabled,
    required this.onRevoke,
    super.key,
  });

  final SessionModel session;
  final bool enabled;
  final VoidCallback onRevoke;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final title =
        session.deviceLabel ??
        session.platformLabel ??
        'settings.sessions.unknown_device'.tr(context: context);
    final lastActive = 'settings.sessions.last_active'.tr(
      context: context,
      args: [RelativeTime.since(session.lastActivityAtUtc, lang)],
    );
    final subtitle = [
      if (session.deviceLabel != null && session.platformLabel != null)
        session.platformLabel!,
      lastActive,
    ].join(' · ');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: session.isCurrent
                  ? AppColors.successLight
                  : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              session.isApple
                  ? Icons.phone_iphone_rounded
                  : Icons.phone_android_rounded,
              color: session.isCurrent
                  ? AppColors.successGreen
                  : AppColors.brandNavy,
              size: 22.r,
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14SemiBold,
                ),
                hSpace(3),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          vSpace(8),
          if (session.isCurrent)
            AppBadgeWidget(
              text: 'settings.sessions.this_device'.tr(context: context),
              type: AppBadgeType.success,
            )
          else
            OutlinedButton(
              onPressed: enabled ? onRevoke : null,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.redText,
                side: const BorderSide(color: AppColors.redBorder),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                minimumSize: Size(0, 34.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                textStyle: AppTextStyles.font13SemiBold,
              ),
              child: Text('settings.sessions.revoke'.tr(context: context)),
            ),
        ],
      ),
    );
  }
}
