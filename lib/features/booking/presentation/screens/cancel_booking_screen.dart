import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/plain_note_box_widget.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../widgets/cancel_footer_widget.dart';
import '../widgets/cancel_refund_box_widget.dart';

class CancelBookingScreen extends HookWidget {
  const CancelBookingScreen({super.key, this.isAfterDeadline = false});

  static const List<String> reasonKeys = [
    'reason_time',
    'reason_players',
    'reason_weather',
    'reason_other',
  ];

  final bool isAfterDeadline;

  @override
  Widget build(BuildContext context) {
    final selectedReason = useState<String?>(null);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.cancel_booking_title'.tr(context: context),
      ),
      bottomNavigationBar: CancelFooterWidget(
        canConfirm: selectedReason.value != null,
        onConfirm: () {
          if (selectedReason.value == null) {
            AppTopSnackBar.showError(
              context,
              'booking.cancel.choose_reason'.tr(context: context),
            );
            return;
          }
          AppTopSnackBar.showSuccess(context, 'booking.cancel.done'.tr(context: context));
          Navigator.of(context).pop();
        },
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
        children: [
          CustomCardWidget(
            padding: EdgeInsets.fromLTRB(16.w, 9.h, 16.w, 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'booking.details.sample_pitch'.tr(context: context),
                  style: AppTextStyles.font15Bold,
                ),
                hSpace(6),
                Text(
                  'booking.cancel.sample_meta'.tr(context: context),
                  style: AppTextStyles.font13Regular,
                ),
              ],
            ),
          ),
          hSpace(12),
          CancelRefundBoxWidget(isAfterDeadline: isAfterDeadline),
          hSpace(12),
          Text(
            '${'booking.cancel.reason_label'.tr(context: context)} *',
            style: AppTextStyles.font14Bold,
          ),
          hSpace(12),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final key in reasonKeys)
                SelectableTileWidget(
                  title: 'booking.cancel.$key'.tr(context: context),
                  isSelected: selectedReason.value == key,
                  onTap: () => selectedReason.value = key,
                  height: 40,
                  borderRadius: 10,
                  horizontalPadding: 12,
                ),
            ],
          ),
          hSpace(12),
          PlainNoteBoxWidget(text: 'booking.cancel.note'.tr(context: context)),
        ],
      ),
    );
  }
}
