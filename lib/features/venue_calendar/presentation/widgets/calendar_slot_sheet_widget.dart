import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/sheet_drag_handle_widget.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_reason_sheet_widget.dart';
import '../../data/models/calendar_slot_model.dart';
import '../cubit/venue_calendar_cubit.dart';
import 'calendar_slot_style.dart';

/// A taken slot's details: confirm or cancel a manual booking, or lift a
/// block.
class CalendarSlotSheetWidget extends StatelessWidget {
  const CalendarSlotSheetWidget({
    required this.slot,
    required this.pitchName,
    required this.canDecide,
    required this.canUnblock,
    required this.cubit,
    super.key,
  });

  final CalendarSlotModel slot;
  final String pitchName;
  final bool canDecide;
  final bool canUnblock;
  final VenueCalendarCubit cubit;

  static Future<void> show(
    BuildContext context, {
    required CalendarSlotModel slot,
    required String pitchName,
    required bool canDecide,
    required bool canUnblock,
    required VenueCalendarCubit cubit,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => CalendarSlotSheetWidget(
      slot: slot,
      pitchName: pitchName,
      canDecide: canDecide,
      canUnblock: canUnblock,
      cubit: cubit,
    ),
  );

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.calendar.slot.$key'.tr(context: context);
    final kind = slot.kind;
    final pendingManual = slot.isManual && slot.status == 'PendingDeposit';
    final title = kind == CalendarSlotKind.blocked
        ? t('blocked_title')
        : (slot.customerName?.isNotEmpty ?? false)
        ? slot.customerName!
        : slot.isManual
        ? 'venue.booking_row.manual'.tr(context: context)
        : t('details');

    Future<void> run(Future<ApiResult<void>> action, String success) async {
      final navigator = Navigator.of(context);
      final result = await action;
      if (!context.mounted) return;
      result.when(
        success: (_) {
          navigator.pop();
          AppTopSnackBar.showSuccess(context, success);
        },
        failure: (f) =>
            AppTopSnackBar.showError(context, f.message.tr(context: context)),
      );
    }

    final rows = <(String, String)>[
      (t('pitch'), pitchName),
      (
        t('time'),
        '${VenueFormat.time(context, slot.startUtc)} – ${VenueFormat.time(context, slot.endUtc)}',
      ),
      if (slot.bookingReference.isNotEmpty)
        (t('reference'), slot.bookingReference),
      if (slot.reason?.isNotEmpty ?? false) (t('reason'), slot.reason!),
      if (kind != CalendarSlotKind.blocked)
        (
          t('customer'),
          (slot.customerName?.isNotEmpty ?? false)
              ? slot.customerName!
              : t('no_name'),
        ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: SheetDragHandleWidget()),
            hSpace(12),
            Row(
              children: [
                Expanded(child: Text(title, style: AppTextStyles.font18Bold)),
                AppBadgeWidget(
                  text: CalendarSlotStyle.label(context, kind),
                  type: CalendarSlotStyle.badge(kind),
                ),
              ],
            ),
            hSpace(12),
            for (final (k, v) in rows)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 96.w,
                      child: Text(
                        k,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(v, style: AppTextStyles.font13SemiBold),
                    ),
                  ],
                ),
              ),
            if (slot.customerPhone?.isNotEmpty ?? false)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  onPressed: () =>
                      launchUrl(Uri(scheme: 'tel', path: slot.customerPhone)),
                  icon: const Icon(Icons.call_rounded, size: 18),
                  label: Text(
                    slot.customerPhone!,
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
            if (slot.isManual) ...[
              hSpace(8),
              Text(
                kind == CalendarSlotKind.tentative
                    ? t('tentative_note')
                    : t('manual_note'),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
            if (kind == CalendarSlotKind.review) ...[
              hSpace(8),
              Text(
                t('review_note'),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.goldText,
                ),
              ),
            ],
            hSpace(16),
            if (pendingManual && canDecide) ...[
              CustomButton(
                text: t('confirm'),
                height: 48.h,
                borderRadius: 14,
                backgroundColor: AppColors.pitchGreen,
                textStyle: AppTextStyles.font15Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () =>
                    run(cubit.confirmManual(slot.id), t('confirmed_toast')),
              ),
              hSpace(8),
            ],
            if (slot.isOpenManual && canDecide) ...[
              CustomButton(
                text: t('cancel'),
                type: CustomButtonType.outline,
                borderColor: AppColors.brandRed,
                foregroundColor: AppColors.brandRed,
                height: 46.h,
                borderRadius: 14,
                onTap: () async {
                  final reason = await VenueReasonSheetWidget.show(
                    context,
                    title: t('cancel'),
                    presets: [t('cancel_reason_1')],
                    note: t('cancel_note'),
                    confirmText: t('cancel_confirm'),
                  );
                  if (reason != null) {
                    await run(
                      cubit.cancelManual(slot.id, reason),
                      t('cancelled_toast'),
                    );
                  }
                },
              ),
              hSpace(8),
            ],
            if (kind == CalendarSlotKind.blocked && canUnblock)
              CustomButton(
                text: t('unblock'),
                type: CustomButtonType.outline,
                height: 46.h,
                borderRadius: 14,
                onTap: () => run(cubit.unblock(slot.id), t('unblocked_toast')),
              ),
          ],
        ),
      ),
    );
  }
}
