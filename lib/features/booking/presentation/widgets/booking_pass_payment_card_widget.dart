import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../data/models/player_booking_detail_model.dart';
import 'booking_detail_row_widget.dart';

class BookingPassPaymentCardWidget extends StatelessWidget {
  const BookingPassPaymentCardWidget({required this.booking, super.key});

  final PlayerBookingDetailModel booking;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String egp(double value) => 'common.price_egp'.tr(
      context: context,
      args: [value.round().toLocalizedDigits(lang)],
    );
    String t(String key) => 'booking.pass.$key'.tr(context: context);

    return CustomCardWidget(
      borderRadius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t('payment'), style: AppTextStyles.font15Bold),
          hSpace(10),
          BookingDetailRowWidget(
            label: t('total'),
            value: egp(booking.totalPrice),
          ),
          BookingDetailRowWidget(
            label: t('deposit'),
            value: egp(booking.depositAmount),
          ),
          BookingDetailRowWidget(
            label: t('at_venue'),
            value: egp(booking.totalPrice - booking.depositAmount),
            isBold: true,
          ),
          if (booking.cancellationPolicySummary case final policy?
              when policy.isNotEmpty) ...[
            hSpace(10),
            Text(policy, style: AppTextStyles.font12Regular),
          ],
        ],
      ),
    );
  }
}
