import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/upload_proof_booking_bloc_builder.dart';

class UploadProofScreen extends StatelessWidget {
  const UploadProofScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.upload_proof_title'.tr(context: context),
      ),
      body: SafeArea(
        child: UploadProofBookingBlocBuilder(bookingId: bookingId),
      ),
    );
  }
}
