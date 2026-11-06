import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/match_result_cubit.dart';
import '../cubit/match_result_state.dart';

class SubmitResultBlocBuilder extends StatelessWidget {
  const SubmitResultBlocBuilder({required this.onSubmit, super.key});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return BottomActionBarWidget(
      child: BlocBuilder<MatchResultCubit, MatchResultState>(
        builder: (context, state) => CustomButton(
          text: 'matches.submit_result_btn'.tr(context: context),
          height: 52.h,
          borderRadius: 16,
          boxShadow: AppShadows.redGlow,
          isLoading: state is MatchResultLoading || state is MatchResultSuccess,
          textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
          onTap: onSubmit,
        ),
      ),
    );
  }
}
