import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/sessions_cubit.dart';
import '../cubit/sessions_state.dart';
import 'session_tile_widget.dart';
import '../../../../core/animations/ball_refresh_indicator.dart';

class SessionsBlocBuilder extends StatelessWidget {
  const SessionsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SessionsCubit>();
    return BlocConsumer<SessionsCubit, SessionsState>(
      listenWhen: (_, current) =>
          current is SessionsSuccess && current.failure != null,
      listener: (context, state) {
        if (state case SessionsSuccess(:final failure?)) {
          AppTopSnackBar.showError(context, failure.tr(context: context));
        }
      },
      builder: (context, state) {
        return switch (state) {
          SessionsSuccess(:final sessions, :final busy) => BallRefreshIndicator(
            onRefresh: cubit.load,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              children: [
                Text(
                  'settings.sessions.description'.tr(context: context),
                  style: AppTextStyles.font13Regular,
                ),
                hSpace(12),
                CustomCardWidget(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (final (i, session) in sessions.indexed) ...[
                        if (i > 0)
                          const Divider(height: 1, color: AppColors.border),
                        SessionTileWidget(
                          session: session,
                          enabled: !busy,
                          onRevoke: () {
                            HapticFeedback.mediumImpact();
                            cubit.revoke(session.sessionId);
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                if (sessions.any((s) => !s.isCurrent)) ...[
                  hSpace(16),
                  CustomButton(
                    text: 'settings.sessions.revoke_others'.tr(
                      context: context,
                    ),
                    type: CustomButtonType.outline,
                    height: 50.h,
                    borderRadius: 12,
                    borderColor: AppColors.redBorder,
                    isLoading: busy,
                    textStyle: AppTextStyles.font15SemiBold.copyWith(
                      color: AppColors.redText,
                    ),
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      cubit.revokeOthers();
                    },
                  ),
                ],
              ],
            ),
          ),
          SessionsError(:final message) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: cubit.load,
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 64, itemCount: 3),
        };
      },
    );
  }
}
