import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class MyTeamCardActionsWidget extends StatelessWidget {
  const MyTeamCardActionsWidget({
    required this.onTeamPage,
    required this.onManage,
    this.showManage = true,
    super.key,
  });

  final VoidCallback onTeamPage;
  final VoidCallback onManage;
  final bool showManage;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.font14SemiBold.copyWith(
      color: AppColors.brandNavy,
    );

    return Container(
      height: 47.h,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lightSurface)),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTeamPage,
              child: Center(
                child: Text(
                  'teams.list.team_page'.tr(context: context),
                  style: style,
                ),
              ),
            ),
          ),
          if (showManage) Container(width: 1, color: AppColors.lightSurface),
          if (showManage)
            Expanded(
              child: InkWell(
                onTap: onManage,
                child: Center(
                  child: Text(
                    'teams.list.manage'.tr(context: context),
                    style: style,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
