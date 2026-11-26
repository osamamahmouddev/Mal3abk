import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/venue_booking_item_model.dart';

class VenueBookingCardWidget extends StatelessWidget {
  const VenueBookingCardWidget({
    required this.booking,
    required this.pitchName,
    required this.canConfirm,
    required this.isConfirming,
    required this.onConfirm,
    required this.onDetails,
    super.key,
  });

  final VenueBookingItemModel booking;
  final String pitchName;
  final bool canConfirm;
  final bool isConfirming;
  final VoidCallback onConfirm;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    final b = booking;
    String t(String key) => 'venue.bookings.card.$key'.tr(context: context);
    final pending = b.status == VenueBookingStatus.pendingDeposit;
    final inReview =
        b.status == VenueBookingStatus.proofSubmitted ||
        b.status == VenueBookingStatus.underReview;
    final depositState = b.isManual
        ? (pending ? t('tentative') : t('pay_at_venue'))
        : pending
        ? t('not_uploaded')
        : inReview
        ? t('proof_uploaded')
        : t('approved');
    final remaining = b.totalPrice - b.depositAmount;

    return CustomCardWidget(
      padding: EdgeInsets.all(14.r),
      borderRadius: 16,
      onTap: onDetails,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  (b.customerName?.isEmpty ?? true) ? '—' : b.customerName!,
                  style: AppTextStyles.font15Bold,
                  overflow: TextOverflow.ellipsis,
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
          hSpace(4),
          Text(
            '${b.isManual ? t('manual') : t('from_app')} · ${b.reference}',
            textDirection: TextDirection.rtl,
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          hSpace(8),
          _Line(
            icon: Icons.schedule_rounded,
            text: '$pitchName · ${VenueFormat.dateTime(context, b.startUtc)}',
          ),
          hSpace(4),
          _Line(
            icon: Icons.payments_outlined,
            text: [
              if (b.depositAmount > 0)
                VenueFormat.money(context, b.depositAmount, b.currency)
              else
                t('no_deposit'),
              depositState,
              if (remaining > 0)
                'venue.booking_row.remaining'.tr(
                  context: context,
                  args: [VenueFormat.money(context, remaining, b.currency)],
                ),
            ].join(' · '),
          ),
          if (!b.isManual && (pending || inReview)) ...[
            hSpace(8),
            Text(
              pending ? t('waiting_deposit') : t('admin_reviewing'),
              style: AppTextStyles.font12SemiBold.copyWith(
                color: AppColors.goldText,
              ),
            ),
          ],
          if (b.isManual && pending && canConfirm) ...[
            hSpace(10),
            CustomButton(
              text: t('confirm'),
              height: 40.h,
              borderRadius: 10,
              isLoading: isConfirming,
              backgroundColor: AppColors.pitchGreen,
              textStyle: AppTextStyles.font13Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: onConfirm,
            ),
          ],
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16.r, color: AppColors.textSecondary),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.textBody,
            ),
          ),
        ),
      ],
    );
  }
}
