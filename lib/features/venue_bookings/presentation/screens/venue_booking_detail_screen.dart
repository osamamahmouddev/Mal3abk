import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_reason_sheet_widget.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_booking_detail_model.dart';
import '../cubit/venue_booking_detail_cubit.dart';
import '../cubit/venue_booking_detail_state.dart';
import '../widgets/venue_bookings_list_widget.dart';

/// A booking's details and the venue's actions on it. Pops `true` when the
/// booking changed so the list reloads.
class VenueBookingDetailScreen extends StatelessWidget {
  const VenueBookingDetailScreen({required this.args, super.key});

  final VenueBookingDetailArgs args;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.booking_detail.$key'.tr(context: context);
    final cubit = context.read<VenueBookingDetailCubit>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(cubit.changed);
      },
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: t('title'),
          onBackTap: () => Navigator.of(context).pop(cubit.changed),
        ),
        body: BlocConsumer<VenueBookingDetailCubit, VenueBookingDetailState>(
          listener: (context, state) {
            if (state case VenueBookingDetailSuccess(:final done?)) {
              AppTopSnackBar.showSuccess(context, t('done_${done.name}'));
            }
            if (state case VenueBookingDetailSuccess(:final actionError?)) {
              AppTopSnackBar.showError(
                context,
                actionError.tr(context: context),
              );
            }
          },
          builder: (context, state) => switch (state) {
            VenueBookingDetailLoading() => const ShimmerListSkeletonWidget(
              itemHeight: 80,
              itemCount: 5,
            ),
            VenueBookingDetailError(:final message) => Padding(
              padding: EdgeInsets.all(16.r),
              child: AlertBannerWidget(
                type: AlertBannerType.error,
                message: message.tr(context: context),
                actionText: 'common.retry'.tr(context: context),
                onActionTap: () => cubit.load(args.venueId, args.bookingId),
              ),
            ),
            VenueBookingDetailSuccess(:final booking, :final busy) =>
              RefreshIndicator(
                onRefresh: () => cubit.load(args.venueId, args.bookingId),
                child: _Body(
                  booking: booking,
                  busy: busy,
                  canApprove: args.canApprove,
                ),
              ),
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.booking,
    required this.busy,
    required this.canApprove,
  });

  final VenueBookingDetailModel booking;
  final VenueBookingAction? busy;
  final bool canApprove;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.booking_detail.$key'.tr(context: context);
    final b = booking;
    final cubit = context.read<VenueBookingDetailCubit>();
    String m(double v) => VenueFormat.money(context, v, b.currency);
    final pending = b.status == VenueBookingStatus.pendingDeposit;
    final inReview =
        b.status == VenueBookingStatus.proofSubmitted ||
        b.status == VenueBookingStatus.underReview;
    final canCancel =
        canApprove && VenueBookingStatus.active.contains(b.status);
    final started = CairoNow.isPast(b.startUtc);
    final canNoShow =
        canApprove && b.status == VenueBookingStatus.confirmed && started;
    final dueAtVenue = b.venuePayAmount > 0
        ? b.venuePayAmount
        : b.totalPrice - b.depositAmount;

    final rows = <(String, String)>[
      (t('reference'), b.reference),
      (t('pitch'), b.pitchName ?? '—'),
      (
        t('time'),
        '${VenueFormat.dateTime(context, b.startUtc)} – ${VenueFormat.time(context, b.endUtc)}',
      ),
      (t('total'), m(b.totalPrice)),
      (t('deposit'), m(b.depositAmount)),
      (
        t('commission'),
        b.platformCommission > 0 ? m(b.platformCommission) : t('exempt'),
      ),
      (
        t('commission_state'),
        b.platformCommission <= 0
            ? t('not_applied')
            : b.isCommissionPaid
            ? t('paid_online')
            : t('not_paid_online'),
      ),
      (t('venue_net'), m(b.venueNetAmount)),
      if (b.totalPrice > b.depositAmount) (t('due_at_venue'), m(dueAtVenue)),
      (t('phone'), b.customerPhone ?? '—'),
      if (pending && b.holdExpiresAtUtc != null)
        (
          t('deposit_deadline'),
          VenueFormat.timeLeft(context, b.holdExpiresAtUtc),
        ),
    ];

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                (b.customerName?.isEmpty ?? true)
                    ? t('title')
                    : b.customerName!,
                style: AppTextStyles.font20Bold,
              ),
            ),
            AppBadgeWidget(
              text: VenueFormat.statusLabel(
                context,
                b.status,
                isManual: b.isManual,
                deposit: b.depositAmount,
              ),
              type: VenueFormat.statusTone(
                b.status,
                isManual: b.isManual,
                deposit: b.depositAmount,
              ),
            ),
          ],
        ),
        hSpace(14),
        VenueSectionCardWidget(
          title: t('summary'),
          child: Column(
            children: [
              for (final (k, v) in rows)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 130.w,
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
            ],
          ),
        ),
        if (b.notes?.isNotEmpty ?? false) ...[
          hSpace(12),
          VenueSectionCardWidget(
            title: t('notes'),
            child: Text(b.notes!, style: AppTextStyles.font13Regular),
          ),
        ],
        hSpace(12),
        VenueSectionCardWidget(
          title: t('history'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final h in b.statusHistory)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text(
                    '• ${VenueFormat.statusLabel(context, h.status)} — ${VenueFormat.dateTime(context, h.changedAtUtc)}${(h.reason?.isNotEmpty ?? false) ? ' (${h.reason})' : ''}',
                    style: AppTextStyles.font12Regular,
                  ),
                ),
            ],
          ),
        ),
        if (!b.isManual && (pending || inReview)) ...[
          hSpace(12),
          _InfoBox(
            title: pending
                ? t('waiting_player_title')
                : t('admin_confirms_title'),
            body: pending ? t('waiting_player_body') : t('admin_confirms_body'),
          ),
        ],
        if (b.isManual && pending) ...[
          hSpace(12),
          _InfoBox(title: t('manual_held_title'), body: t('manual_held_body')),
          if (canApprove) ...[
            hSpace(10),
            CustomButton(
              text: t('confirm_now'),
              height: 50.h,
              borderRadius: 14,
              backgroundColor: AppColors.pitchGreen,
              isLoading: busy == VenueBookingAction.confirm,
              textStyle: AppTextStyles.font15Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: cubit.confirmManual,
            ),
          ],
        ],
        if (canNoShow) ...[
          hSpace(12),
          CustomButton(
            text: t('no_show'),
            type: CustomButtonType.outline,
            height: 48.h,
            borderRadius: 14,
            isLoading: busy == VenueBookingAction.noShow,
            onTap: () async {
              final reason = await VenueReasonSheetWidget.show(
                context,
                title: t('no_show'),
                presets: [t('no_show_reason_1'), t('no_show_reason_2')],
                note: t('no_show_note'),
                confirmText: 'common.confirm'.tr(context: context),
              );
              if (reason != null) await cubit.markNoShow(reason);
            },
          ),
        ],
        if (canCancel) ...[
          hSpace(12),
          CustomButton(
            text: b.isManual ? t('cancel_manual') : t('cancel_app'),
            type: CustomButtonType.outline,
            borderColor: AppColors.brandRed,
            foregroundColor: AppColors.brandRed,
            height: 48.h,
            borderRadius: 14,
            isLoading: busy == VenueBookingAction.cancel,
            onTap: () async {
              final reason = await VenueReasonSheetWidget.show(
                context,
                title: 'venue.booking_detail.cancel_title'.tr(
                  context: context,
                  args: [
                    (b.customerName?.isEmpty ?? true)
                        ? b.reference
                        : b.customerName!,
                  ],
                ),
                presets: [
                  t('cancel_reason_1'),
                  t('cancel_reason_2'),
                  t('cancel_reason_3'),
                ],
                note: b.isManual
                    ? t('cancel_manual_note')
                    : 'venue.booking_detail.cancel_app_note'.tr(
                        context: context,
                        args: [m(b.depositAmount)],
                      ),
                confirmText: b.isManual
                    ? t('cancel_confirm_manual')
                    : t('cancel_confirm_app'),
              );
              if (reason != null) await cubit.cancel(reason);
            },
          ),
          hSpace(6),
          Text(
            b.isManual ? t('cancel_manual_hint') : t('cancel_app_hint'),
            textAlign: TextAlign.center,
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.tableHead,
        border: Border.all(color: AppColors.borderCard),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.font14Bold),
          hSpace(4),
          Text(
            body,
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.textBody,
            ),
          ),
        ],
      ),
    );
  }
}

/// Whether a UTC instant from the API has already passed.
abstract final class CairoNow {
  static bool isPast(String utc) =>
      !(DateTime.tryParse(utc)?.isAfter(DateTime.now().toUtc()) ?? true);
}
