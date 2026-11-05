import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../data/models/challenge_details_model.dart';
import '../cubit/challenge_response_cubit.dart';
import '../cubit/challenge_response_state.dart';
import 'counter_proposal_sheet_widget.dart';

class ChallengeResponseActionsBlocBuilder extends StatelessWidget {
  const ChallengeResponseActionsBlocBuilder({required this.details, super.key});

  final ChallengeDetailsModel details;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChallengeResponseCubit>();
    final challengeId = details.challenge.id;
    final teamId = details.myTeam!.id;
    String t(String key) => 'matches.challenge.$key'.tr(context: context);

    void confirmDecline() {
      final navigator = Navigator.of(context);
      CustomDialogWidget.show<void>(
        context: context,
        title: t('decline_confirm_title'),
        description: t('decline_confirm_desc'),
        primaryActionText: 'matches.decline_challenge'.tr(context: context),
        secondaryActionText: 'common.cancel'.tr(context: context),
        isDestructive: true,
        onPrimaryAction: () {
          navigator.pop();
          cubit.decline(challengeId, teamId);
        },
        onSecondaryAction: navigator.pop,
      );
    }

    return BlocBuilder<ChallengeResponseCubit, ChallengeResponseState>(
      builder: (context, state) {
        final busy = state is ChallengeResponseLoading;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'matches.decline_challenge'.tr(context: context),
                    type: CustomButtonType.outline,
                    height: 50.h,
                    borderRadius: 12,
                    borderColor: AppColors.redBorder,
                    enabled: !busy,
                    textStyle: AppTextStyles.font15SemiBold.copyWith(
                      color: AppColors.redText,
                    ),
                    onTap: confirmDecline,
                  ),
                ),
                vSpace(8),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    text: 'matches.accept_challenge'.tr(context: context),
                    height: 50.h,
                    borderRadius: 12,
                    boxShadow: AppShadows.redGlow,
                    isLoading: busy,
                    textStyle: AppTextStyles.font16Bold.copyWith(
                      color: AppColors.white,
                    ),
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      cubit.accept(challengeId, teamId);
                    },
                  ),
                ),
              ],
            ),
            hSpace(8),
            CustomButton(
              text: t('counter'),
              type: CustomButtonType.ghost,
              height: 44.h,
              enabled: !busy,
              textStyle: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.brandNavy,
              ),
              onTap: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: AppColors.transparent,
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: CounterProposalSheetWidget(
                    challengeId: challengeId,
                    teamId: teamId,
                    durationMinutes: details.challenge.proposedDurationMinutes,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
