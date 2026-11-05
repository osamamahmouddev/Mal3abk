import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/challenge_details_cubit.dart';
import '../cubit/challenge_details_state.dart';
import 'challenge_response_actions_bloc_builder.dart';

class ChallengeDetailsFooterBlocBuilder extends StatelessWidget {
  const ChallengeDetailsFooterBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeDetailsCubit, ChallengeDetailsState>(
      builder: (context, state) {
        if (state is! ChallengeDetailsSuccess) return const SizedBox.shrink();
        final details = state.details;
        if (details.canRespond) {
          return BottomActionBarWidget(
            child: ChallengeResponseActionsBlocBuilder(details: details),
          );
        }
        final matchId = details.challenge.matchId;
        if (matchId == null) return const SizedBox.shrink();
        return BottomActionBarWidget(
          child: CustomButton(
            text: 'matches.challenge.view_match'.tr(context: context),
            height: 52.h,
            borderRadius: 16,
            textStyle: AppTextStyles.font16Bold.copyWith(
              color: AppColors.white,
            ),
            onTap: () => Navigator.of(
              context,
            ).pushNamed(AppRoutes.matchDetails, arguments: matchId),
          ),
        );
      },
    );
  }
}
