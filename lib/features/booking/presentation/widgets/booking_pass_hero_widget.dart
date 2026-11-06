import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../data/models/player_booking_detail_model.dart';
import 'booking_status_style.dart';

class BookingPassHeroWidget extends StatelessWidget {
  const BookingPassHeroWidget({required this.booking, super.key});

  final PlayerBookingDetailModel booking;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final daysLeft = DateTime(
      CairoTime.fromUtc(booking.startAt).year,
      CairoTime.fromUtc(booking.startAt).month,
      CairoTime.fromUtc(booking.startAt).day,
    ).difference(CairoTime.today()).inDays;
    final when = switch (daysLeft) {
      < 0 => null,
      0 => 'booking.pass.today'.tr(context: context),
      1 => 'booking.pass.tomorrow'.tr(context: context),
      _ => 'booking.pass.in_days'.tr(
        context: context,
        args: [daysLeft.toLocalizedDigits(lang)],
      ),
    };

    return Hero(
      tag: 'booking-${booking.id}',
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.brandNavy,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                AppAssets.bookingHeroPattern,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      AppBadgeWidget(
                        text: BookingStatusStyle.labelKey(
                          booking.status,
                        ).tr(context: context),
                        type: BookingStatusStyle.badge(booking.status),
                      ),
                      const Spacer(),
                      if (when != null && !booking.status.isClosed)
                        Text(
                          when,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.onNavyMuted,
                          ),
                        ),
                    ],
                  ),
                  hSpace(8),
                  Text(
                    booking.venue?.name ?? '',
                    style: AppTextStyles.font20Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  if (booking.pitchName case final pitch?) ...[
                    hSpace(2),
                    Text(
                      pitch,
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.onNavySoft,
                      ),
                    ),
                  ],
                  hSpace(10),
                  Text(
                    '${CairoTime.dayAndTime(booking.startAt, lang)} – ${CairoTime.time(booking.endAt, lang)}',
                    style: AppTextStyles.font15Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  hSpace(12),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white8,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'booking.deposit.booking_no'.tr(context: context),
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.onNavyMuted,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          booking.reference,
                          textDirection: TextDirection.ltr,
                          style: AppTextStyles.font15Bold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
