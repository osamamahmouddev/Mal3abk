import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../data/models/session_model.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(
            Icons.smartphone_rounded,
            color: AppColors.brandNavy,
            size: 24.sp,
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14SemiBold,
                ),
                hSpace(2),
                Text(
                  'settings.sessions.last_active'.tr(
                    context: context,
                    args: [RelativeTime.since(session.lastActivityAtUtc, lang)],
                  ),
                  style: AppTextStyles.font11Regular,
                ),
              ],
            ),
          ),
          if (session.isCurrent)
            AppBadgeWidget(
              text: 'settings.sessions.this_device'.tr(context: context),
              type: AppBadgeType.success,
            )
          else
            TextButton(
              onPressed: enabled ? onRevoke : null,
              child: Text(
                'settings.sessions.revoke'.tr(context: context),
                style: AppTextStyles.font13SemiBold.copyWith(
                  color: AppColors.redText,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
