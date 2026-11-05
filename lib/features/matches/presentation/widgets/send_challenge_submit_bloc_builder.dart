import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/send_challenge_cubit.dart';
import '../cubit/send_challenge_state.dart';

class SendChallengeSubmitBlocBuilder extends StatelessWidget {
  const SendChallengeSubmitBlocBuilder({
    required this.summary,
    required this.onSubmit,
    super.key,
  });

  final String summary;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BottomActionBarWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            summary,
            textAlign: TextAlign.center,
            style: AppTextStyles.font12Regular,
          ),
          hSpace(8),
          BlocBuilder<SendChallengeCubit, SendChallengeState>(
            builder: (context, state) => CustomButton(
              text: 'matches.challenge.send'.tr(context: context),
              height: 52.h,
              borderRadius: 16,
              boxShadow: AppShadows.redGlow,
              enabled: onSubmit != null,
              isLoading:
                  state is SendChallengeLoading ||
                  state is SendChallengeSuccess,
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: onSubmit ?? () {},
            ),
          ),
        ],
      ),
    );
  }
}
