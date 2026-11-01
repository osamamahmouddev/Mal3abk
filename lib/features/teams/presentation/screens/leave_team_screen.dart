import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';

class LeaveTeamScreen extends HookWidget {
  const LeaveTeamScreen({super.key});

  static const List<String> reasonKeys = ['r1', 'r2', 'r3', 'r4'];

  @override
  Widget build(BuildContext context) {
    final selectedReason = useState<String?>(null);
    String t(String key) => 'teams.leave.$key'.tr(context: context);
    final warnStyle = AppTextStyles.font13Regular.copyWith(
      color: AppColors.goldText,
      height: 21 / 13,
    );

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(title: t('title')),
      bottomNavigationBar: BottomActionBarWidget(
        child: Row(
          children: [
            Expanded(
              flex: 170,
              child: CustomButton(
                text: t('stay'),
                type: CustomButtonType.outline,
                height: 54.h,
                borderRadius: 16,
                textStyle: AppTextStyles.font15SemiBold.copyWith(
                  color: AppColors.brandNavy,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            vSpace(8),
            Expanded(
              flex: 180,
              child: CustomButton(
                text: t('confirm'),
                height: 54.h,
                borderRadius: 16,
                backgroundColor: AppColors.redText,
                textStyle: AppTextStyles.font15Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        children: [
          CustomCardWidget(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                InitialsAvatarWidget(
                  initials: 'teams.sample.abtal_i'.tr(context: context),
                  color: AppColors.successGreen,
                  size: 52,
                  textStyle: AppTextStyles.font18Bold,
                ),
                vSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t('team_name'), style: AppTextStyles.font16Bold),
                      hSpace(4),
                      Text(t('team_meta'), style: AppTextStyles.font12Regular),
                    ],
                  ),
                ),
              ],
            ),
          ),
          hSpace(14),
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 9.h, 16.w, 14.h),
            decoration: BoxDecoration(
              color: AppColors.goldLight,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t('warning_title'),
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.goldText,
                  ),
                ),
                for (final key in const ['w1', 'w2', 'w3']) ...[
                  hSpace(8),
                  Text(t(key), style: warnStyle),
                ],
              ],
            ),
          ),
          hSpace(10),
          Text(t('reason'), style: AppTextStyles.font14Bold),
          hSpace(14),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final key in reasonKeys)
                SelectableTileWidget(
                  title: t(key),
                  isSelected: selectedReason.value == key,
                  onTap: () => selectedReason.value = key,
                  height: 40,
                  borderRadius: 12,
                  horizontalPadding: 12,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
