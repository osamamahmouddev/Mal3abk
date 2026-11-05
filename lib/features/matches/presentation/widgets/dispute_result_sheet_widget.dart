import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/match_result_cubit.dart';

class DisputeResultSheetWidget extends HookWidget {
  const DisputeResultSheetWidget({
    required this.matchId,
    required this.teamId,
    super.key,
  });

  final String matchId;
  final String teamId;

  @override
  Widget build(BuildContext context) {
    final reason = useTextEditingController();
    final text = useValueListenable(reason);
    final valid =
        text.text.trim().length >= MatchResultCubit.minDisputeReasonLength;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'matches.match.dispute_title'.tr(context: context),
                  style: AppTextStyles.font18Bold,
                ),
                hSpace(6),
                Text(
                  'matches.match.dispute_desc'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
                hSpace(14),
                CustomTextFormField(
                  controller: reason,
                  autofocus: true,
                  hintText: 'matches.match.dispute_hint'.tr(context: context),
                  minLines: 3,
                  maxLines: 5,
                ),
                hSpace(16),
                CustomButton(
                  text: 'matches.match.dispute_send'.tr(context: context),
                  height: 50.h,
                  borderRadius: 12,
                  enabled: valid,
                  backgroundColor: AppColors.brandRed,
                  textStyle: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.white,
                  ),
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    context.read<MatchResultCubit>().dispute(
                      matchId,
                      teamId: teamId,
                      reason: reason.text,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
