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
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/match_details_model.dart';
import '../cubit/match_details_cubit.dart';
import '../cubit/match_result_cubit.dart';
import '../cubit/match_result_state.dart';
import 'dispute_result_sheet_widget.dart';

class MatchResultActionsBlocBuilder extends StatelessWidget {
  const MatchResultActionsBlocBuilder({required this.details, super.key});

  final MatchDetailsModel details;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MatchResultCubit>();
    final match = details.match;
    final teamId = details.myTeam!.id;
    final primaryStyle = AppTextStyles.font16Bold.copyWith(
      color: AppColors.white,
    );

    if (!details.canVerifyResult) {
      return CustomButton(
        text: 'matches.submit_result_title'.tr(context: context),
        height: 52.h,
        borderRadius: 16,
        boxShadow: AppShadows.redGlow,
        textStyle: primaryStyle,
        onTap: () async {
          final submitted = await Navigator.of(
            context,
          ).pushNamed(AppRoutes.submitResult, arguments: details);
          if (submitted == true && context.mounted) {
            await context.read<MatchDetailsCubit>().load(match.id);
          }
        },
      );
    }

    return BlocBuilder<MatchResultCubit, MatchResultState>(
      builder: (context, state) {
        final busy = state is MatchResultLoading;
        return Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'matches.match.dispute'.tr(context: context),
                type: CustomButtonType.outline,
                height: 52.h,
                borderRadius: 12,
                borderColor: AppColors.redBorder,
                enabled: !busy,
                textStyle: AppTextStyles.font15SemiBold.copyWith(
                  color: AppColors.redText,
                ),
                onTap: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.transparent,
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: DisputeResultSheetWidget(
                      matchId: match.id,
                      teamId: teamId,
                    ),
                  ),
                ),
              ),
            ),
            vSpace(8),
            Expanded(
              flex: 2,
              child: CustomButton(
                text: 'matches.match.confirm'.tr(context: context),
                height: 52.h,
                borderRadius: 12,
                isLoading: busy,
                backgroundColor: AppColors.successGreen,
                textStyle: primaryStyle,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  cubit.confirm(match.id, teamId: teamId);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
