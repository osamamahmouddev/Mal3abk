import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/team_invite_preview_cubit.dart';
import '../cubit/team_invite_preview_state.dart';
import 'team_invite_preview_card_widget.dart';

/// The team a complete code leads to, so the player sees where they are
/// joining before they tap join.
class TeamInvitePreviewBlocBuilder extends StatelessWidget {
  const TeamInvitePreviewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamInvitePreviewCubit, TeamInvitePreviewState>(
      builder: (context, state) => AnimatedSize(
        duration: AppAnimations.duration(context, AppAnimations.base),
        curve: AppAnimations.standard,
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(
            top: state is TeamInvitePreviewInitial ? 0 : 14.h,
          ),
          child: switch (state) {
            TeamInvitePreviewInitial() => const SizedBox(
              width: double.infinity,
            ),
            TeamInvitePreviewLoading() => const ShimmerListSkeletonWidget(
              itemHeight: 76,
              itemCount: 1,
              padding: EdgeInsets.zero,
            ),
            TeamInvitePreviewError(:final message) => Text(
              message.tr(context: context),
              style: AppTextStyles.font13SemiBold.copyWith(
                color: AppColors.redText,
              ),
            ),
            TeamInvitePreviewSuccess(:final preview) =>
              TeamInvitePreviewCardWidget(preview: preview),
          },
        ),
      ),
    );
  }
}
