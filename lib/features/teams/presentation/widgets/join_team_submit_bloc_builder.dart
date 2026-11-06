import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/join_team_cubit.dart';
import '../cubit/join_team_state.dart';

class JoinTeamSubmitBlocBuilder extends StatelessWidget {
  const JoinTeamSubmitBlocBuilder({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinTeamCubit, JoinTeamState>(
      builder: (context, state) => CustomButton(
        text: 'teams.join.submit_code'.tr(context: context),
        height: 52.h,
        borderRadius: 16,
        isLoading: state is JoinTeamLoading,
        textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
        onTap: () => context.read<JoinTeamCubit>().join(controller.text),
      ),
    );
  }
}
