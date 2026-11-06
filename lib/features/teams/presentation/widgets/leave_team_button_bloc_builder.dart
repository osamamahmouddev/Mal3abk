import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/team_action_cubit.dart';
import '../cubit/team_action_state.dart';

class LeaveTeamButtonBlocBuilder extends StatelessWidget {
  const LeaveTeamButtonBlocBuilder({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamActionCubit, TeamActionState>(
      builder: (context, state) => CustomButton(
        text: 'teams.leave.confirm'.tr(context: context),
        height: 54.h,
        borderRadius: 16,
        isLoading: state is TeamActionLoading,
        backgroundColor: AppColors.redText,
        textStyle: AppTextStyles.font15Bold.copyWith(color: AppColors.white),
        onTap: () => context.read<TeamActionCubit>().leaveTeam(teamId),
      ),
    );
  }
}
