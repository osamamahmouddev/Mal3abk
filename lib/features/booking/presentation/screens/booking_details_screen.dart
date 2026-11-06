import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/app_header_icon_button_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/booking_details_bloc_builder.dart';
import '../widgets/booking_details_footer_bloc_builder.dart';

/// The booking pass: status, QR code, directions, calendar and sharing.
class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.details_title'.tr(context: context),
        actions: [
          AppHeaderIconButtonWidget(
            iconAsset: AppAssets.icHelp,
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.helpAndSupport),
          ),
        ],
      ),
      bottomNavigationBar: const BookingDetailsFooterBlocBuilder(),
      body: SafeArea(child: BookingDetailsBlocBuilder(bookingId: bookingId)),
    );
  }
}
