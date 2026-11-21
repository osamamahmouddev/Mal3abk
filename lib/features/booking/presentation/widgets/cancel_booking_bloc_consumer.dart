import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/plain_note_box_widget.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../cubit/cancel_booking_cubit.dart';
import '../cubit/cancel_booking_state.dart';
import 'cancel_booking_skeleton_widget.dart';
import 'cancel_footer_widget.dart';
import 'cancel_refund_box_widget.dart';

class CancelBookingBlocConsumer extends HookWidget {
  const CancelBookingBlocConsumer({required this.bookingId, super.key});

  static const List<String> reasonKeys = [
    'reason_time',
    'reason_players',
    'reason_weather',
    'reason_other',
  ];

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final reason = useState<String?>(null);
    final cubit = context.read<CancelBookingCubit>();

    return BlocConsumer<CancelBookingCubit, CancelBookingState>(
      listener: (context, state) {
        switch (state) {
          case CancelBookingCancelled():
            HapticFeedback.mediumImpact();
            AppTopSnackBar.showSuccess(
              context,
              'booking.cancel.done'.tr(context: context),
            );
            Navigator.of(context).pop(true);
          case CancelBookingReady(:final failure?):
            HapticFeedback.heavyImpact();
            AppTopSnackBar.showError(context, failure.tr(context: context));
          default:
            break;
        }
      },
      builder: (context, state) {
        final ready = state is CancelBookingReady ? state : null;
        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: CustomAppBarWidget(
            title: 'booking.cancel_booking_title'.tr(context: context),
          ),
          bottomNavigationBar: ready == null || !ready.preview.canCancel
              ? null
              : CancelFooterWidget(
                  canConfirm: reason.value != null && !ready.submitting,
                  onConfirm: () => cubit.cancel(
                    bookingId,
                    reason: 'booking.cancel.${reason.value}'.tr(
                      context: context,
                    ),
                  ),
                ),
          body: switch (state) {
            CancelBookingReady(:final preview) => ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(16.r),
              children: [
                if (!preview.canCancel) ...[
                  AlertBannerWidget(
                    type: AlertBannerType.error,
                    message: 'booking.cancel.not_allowed'.tr(context: context),
                  ),
                  hSpace(12),
                ],
                CancelRefundBoxWidget(preview: preview),
                if (preview.canCancel) ...[
                  hSpace(18),
                  Text(
                    '${'booking.cancel.reason_label'.tr(context: context)} *',
                    style: AppTextStyles.font15Bold,
                  ),
                  hSpace(10),
                  for (final key in reasonKeys) ...[
                    SelectableTileWidget(
                      title: 'booking.cancel.$key'.tr(context: context),
                      isSelected: reason.value == key,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        reason.value = key;
                      },
                      height: 48,
                      borderRadius: 12,
                    ),
                    hSpace(8),
                  ],
                  hSpace(6),
                  PlainNoteBoxWidget(
                    text: 'booking.cancel.note'.tr(context: context),
                  ),
                ],
              ],
            ),
            CancelBookingError(:final message) => CustomStateWidget(
              title: message.tr(context: context),
              description: '',
              actionText: 'common.retry'.tr(context: context),
              onActionTap: () => cubit.loadPreview(bookingId),
            ),
            _ => const CancelBookingSkeletonWidget(),
          },
        );
      },
    );
  }
}
