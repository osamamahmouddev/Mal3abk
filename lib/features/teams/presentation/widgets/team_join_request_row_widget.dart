import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';
import '../../data/models/team_join_request_model.dart';
import '../cubit/team_action_cubit.dart';

class TeamJoinRequestRowWidget extends StatelessWidget {
  const TeamJoinRequestRowWidget({required this.request, super.key});

  final TeamJoinRequestModel request;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final name = request.playerName ?? '—';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Row(
        children: [
          InitialsAvatarWidget(
            initials: name.initials,
            color: AppColors.brandNavy,
            size: 40,
          ),
          vSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.font14Bold),
                hSpace(2),
                Text(
                  request.message ??
                      CairoTime.shortDate(request.createdAtUtc, lang),
                  style: AppTextStyles.font12Regular,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          CustomButton(
            text: 'teams.requests.decline'.tr(context: context),
            type: CustomButtonType.outline,
            height: 36.h,
            borderRadius: 10,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            textStyle: AppTextStyles.font13SemiBold.copyWith(
              color: AppColors.brandNavy,
            ),
            onTap: () => context.read<TeamActionCubit>().declineRequest(
              request.teamId,
              request.id,
            ),
          ),
          vSpace(6),
          CustomButton(
            text: 'teams.requests.approve'.tr(context: context),
            height: 36.h,
            borderRadius: 10,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            textStyle: AppTextStyles.font13SemiBold.copyWith(
              color: AppColors.white,
            ),
            onTap: () => context.read<TeamActionCubit>().approveRequest(
              request.teamId,
              request.id,
            ),
          ),
        ],
      ),
    );
  }
}
