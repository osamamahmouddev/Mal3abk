import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';

/// Explains why the venue is not visible to players yet and links to the
/// setup to fix it, like the web dashboard's banners.
class VenueApprovalBannerWidget extends StatelessWidget {
  const VenueApprovalBannerWidget({
    required this.status,
    this.adminMessage,
    super.key,
  });

  final String status;
  final String? adminMessage;

  @override
  Widget build(BuildContext context) {
    final (key, icon, bg, border, fg, canEdit) = switch (status) {
      'NeedsInfo' => (
        'needs_info',
        Icons.warning_amber_rounded,
        AppColors.goldLight,
        AppColors.goldBorder,
        AppColors.goldText,
        true,
      ),
      'Rejected' => (
        'rejected',
        Icons.cancel_outlined,
        AppColors.redLight,
        AppColors.redBorder,
        AppColors.redText,
        true,
      ),
      'Submitted' => (
        'submitted',
        Icons.hourglass_top_rounded,
        AppColors.tableHead,
        AppColors.borderCard,
        AppColors.brandNavy,
        false,
      ),
      'Suspended' => (
        'suspended',
        Icons.pause_circle_outline_rounded,
        AppColors.redLight,
        AppColors.redBorder,
        AppColors.redText,
        false,
      ),
      _ => (
        'draft',
        Icons.edit_note_rounded,
        AppColors.tableHead,
        AppColors.borderCard,
        AppColors.brandNavy,
        true,
      ),
    };
    String t(String part) => 'venue.approval.$key.$part'.tr(context: context);
    final message = adminMessage;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Semantics(
        liveRegion: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: fg, size: 22.r),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t('title'),
                        style: AppTextStyles.font14Bold.copyWith(color: fg),
                      ),
                      hSpace(4),
                      Text(
                        message != null && canEdit
                            ? '${t('admin_prefix')} $message'
                            : t('body'),
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.textBody,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (canEdit) ...[
              hSpace(12),
              CustomButton(
                text: t('action'),
                type: CustomButtonType.outline,
                height: 42.h,
                borderRadius: 12,
                onTap: () async {
                  final cubit = context.read<VenueSessionCubit>();
                  final state = cubit.state;
                  if (state is! VenueSessionReady) return;
                  await context.pushNamed<String>(
                    AppRoutes.venueSetup,
                    arguments: state.venue,
                  );
                  await cubit.load();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
