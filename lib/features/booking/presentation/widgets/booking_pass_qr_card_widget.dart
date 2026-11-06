import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

/// The booking reference as a QR code for the venue to scan at the gate.
class BookingPassQrCardWidget extends StatelessWidget {
  const BookingPassQrCardWidget({required this.reference, super.key});

  final String reference;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      borderRadius: 18,
      child: Column(
        children: [
          QrImageView(
            data: reference,
            size: 180.r,
            backgroundColor: AppColors.white,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: AppColors.brandNavy,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: AppColors.brandNavy,
            ),
            semanticsLabel: reference,
          ),
          hSpace(10),
          Text(
            'booking.pass.qr_hint'.tr(context: context),
            textAlign: TextAlign.center,
            style: AppTextStyles.font12Regular,
          ),
        ],
      ),
    );
  }
}
