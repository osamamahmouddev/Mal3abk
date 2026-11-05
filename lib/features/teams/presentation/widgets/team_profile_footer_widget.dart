import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/team_profile_model.dart';
import '../cubit/team_action_cubit.dart';

class TeamProfileFooterWidget extends StatelessWidget {
  const TeamProfileFooterWidget({required this.profile, super.key});

  final TeamProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final outlineStyle = AppTextStyles.font15SemiBold.copyWith(
      color: AppColors.brandNavy,
    );
    final primaryStyle = AppTextStyles.font16Bold.copyWith(
      color: AppColors.white,
    );

    if (!profile.isCallerMember) {
      return BottomActionBarWidget(
        child: Row(
          children: [
            if (profile.isRecruiting)
              Expanded(
                child: CustomButton(
                  text: 'teams.profile.request_join'.tr(context: context),
                  type: CustomButtonType.outline,
                  height: 54.h,
                  borderRadius: 16,
                  textStyle: outlineStyle,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    context.read<TeamActionCubit>().requestToJoin(profile.id);
                  },
                ),
              ),
            if (profile.isRecruiting && profile.canBeChallenged) vSpace(8),
            if (profile.canBeChallenged)
              Expanded(
                child: CustomButton(
                  text: 'teams.profile.challenge'.tr(context: context),
                  height: 54.h,
                  borderRadius: 16,
                  boxShadow: AppShadows.redGlow,
                  textStyle: primaryStyle,
                  onTap: () => navigator.pushNamed(
                    AppRoutes.challengeTeam,
                    arguments: profile.id,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return BottomActionBarWidget(
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'teams.profile.tactics'.tr(context: context),
              type: CustomButtonType.outline,
              height: 52.h,
              borderRadius: 12,
              textStyle: outlineStyle,
              onTap: () => navigator.pushNamed(
                AppRoutes.tacticalBoard,
                arguments: profile,
              ),
            ),
          ),
          vSpace(8),
          Expanded(
            child: profile.isCaptain
                ? CustomButton(
                    text: 'teams.profile.invite'.tr(context: context),
                    height: 52.h,
                    borderRadius: 12,
                    boxShadow: AppShadows.redGlow,
                    textStyle: primaryStyle,
                    onTap: () => navigator.pushNamed(
                      AppRoutes.invitePlayers,
                      arguments: profile.id,
                    ),
                  )
                : CustomButton(
                    text: 'teams.profile.leave'.tr(context: context),
                    type: CustomButtonType.outline,
                    height: 52.h,
                    borderRadius: 12,
                    borderColor: AppColors.redBorder,
                    textStyle: outlineStyle.copyWith(color: AppColors.redText),
                    onTap: () => navigator.pushNamed(
                      AppRoutes.leaveTeam,
                      arguments: profile,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
