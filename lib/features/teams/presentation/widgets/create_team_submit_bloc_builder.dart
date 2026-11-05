import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/create_team_cubit.dart';
import '../cubit/create_team_state.dart';

class CreateTeamSubmitBlocBuilder extends StatelessWidget {
  const CreateTeamSubmitBlocBuilder({required this.onSubmit, super.key});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTeamCubit, CreateTeamState>(
      builder: (context, state) => CustomButton(
        text: 'teams.create.submit'.tr(context: context),
        height: 52.h,
        borderRadius: 16,
        boxShadow: AppShadows.redGlow,
        isLoading: state is CreateTeamLoading,
        textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
        onTap: onSubmit,
      ),
    );
  }
}
