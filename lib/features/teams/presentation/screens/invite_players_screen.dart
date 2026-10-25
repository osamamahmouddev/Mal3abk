import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_search_field_widget.dart';
import '../widgets/invite_code_card_widget.dart';
import '../widgets/invite_players_list_widget.dart';

class InvitePlayersScreen extends StatelessWidget {
  const InvitePlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.invite.title'.tr(context: context),
        subtitle: 'teams.profile.mine_name'.tr(context: context),
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'teams.invite.footer_note'.tr(context: context),
              style: AppTextStyles.font12Regular,
            ),
            hSpace(8),
            CustomButton(
              text: 'teams.invite.done'.tr(context: context),
              type: CustomButtonType.secondary,
              height: 52.h,
              borderRadius: 16,
              textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.manageMembers),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 17.h, 16.w, 16.h),
        children: [
          InviteCodeCardWidget(code: 'teams.invite.sample_code'.tr(context: context)),
          hSpace(12),
          Text('teams.invite.search_title'.tr(context: context), style: AppTextStyles.font15Bold),
          hSpace(14),
          CustomSearchFieldWidget(hintText: 'teams.invite.search_hint'.tr(context: context)),
          hSpace(10),
          const InvitePlayersListWidget(),
        ],
      ),
    );
  }
}
