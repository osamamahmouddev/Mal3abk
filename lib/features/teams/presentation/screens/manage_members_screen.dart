import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_header_icon_button_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/pending_invite_row_widget.dart';
import '../widgets/team_member_row_widget.dart';

class ManageMembersScreen extends StatelessWidget {
  const ManageMembersScreen({super.key});

  static const List<String> memberKeys = ['karim', 'mohamed', 'youssef_h', 'ziad'];

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'teams.$key'.tr(context: context);
    final leaveNote = t('manage.leave_note');

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: t('manage.title'),
        subtitle: t('manage.subtitle'),
        actions: [
          AppHeaderIconButtonWidget(
            iconAsset: AppAssets.icUserPlus,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.invitePlayers),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        children: [
          CustomCardWidget(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                TeamMemberRowWidget(
                  initials: t('sample.ahmed_i'),
                  name: 'teams.manage.you_suffix'.tr(context: context, args: [t('sample.ahmed')]),
                  details: t('manage.m_ahmed'),
                  isCaptain: true,
                ),
                for (final key in memberKeys)
                  TeamMemberRowWidget(
                    initials: t('sample.${key}_i'),
                    name: t('sample.$key'),
                    details: t('manage.m_$key'),
                    isCaptain: false,
                    onOptions: () {},
                  ),
              ],
            ),
          ),
          hSpace(10),
          Text(
            t('manage.pending_title'),
            style: AppTextStyles.font14Bold.copyWith(color: AppColors.textSecondary),
          ),
          hSpace(14),
          CustomCardWidget(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                PendingInviteRowWidget(
                  initials: t('sample.hany_i'),
                  title: t('sample.hany'),
                  meta: t('manage.sent_2_days'),
                  onCancel: () {},
                ),
                PendingInviteRowWidget(
                  initials: t('manage.code_i'),
                  title: 'teams.manage.code_invite'.tr(context: context, args: [t('invite.sample_code')]),
                  meta: t('manage.code_valid'),
                  onCancel: () {},
                ),
              ],
            ),
          ),
          hSpace(18),
          CustomButton(
            text: t('manage.leave'),
            type: CustomButtonType.outline,
            height: 48.h,
            borderRadius: 12,
            backgroundColor: AppColors.white,
            borderColor: AppColors.border,
            textStyle: AppTextStyles.font14SemiBold.copyWith(color: AppColors.textDisabled),
            onTap: () => AppTopSnackBar.showError(context, leaveNote),
          ),
          hSpace(4),
          Text(leaveNote, style: AppTextStyles.font12Regular, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
