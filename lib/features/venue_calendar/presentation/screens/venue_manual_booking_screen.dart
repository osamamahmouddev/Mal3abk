import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../cubit/manual_booking_cubit.dart';
import '../cubit/manual_booking_state.dart';
import '../widgets/manual_booking_form_widget.dart';

/// What opens the manual booking form: the venue and, from a calendar
/// hour, its pitch, date and start.
class VenueManualBookingArgs {
  const VenueManualBookingArgs({
    required this.venue,
    this.pitchId,
    this.date,
    this.startMinutes,
    this.customerName,
    this.customerPhone,
  });

  final VenueModel venue;
  final String? pitchId;
  final DateTime? date;
  final int? startMinutes;

  /// Prefilled when booking for a known customer.
  final String? customerName;
  final String? customerPhone;
}

/// A phone or walk-in booking. Pops `true` once it was saved.
class VenueManualBookingScreen extends StatelessWidget {
  const VenueManualBookingScreen({
    required this.venue,
    this.customerName,
    this.customerPhone,
    super.key,
  });

  final VenueModel venue;
  final String? customerName;
  final String? customerPhone;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManualBookingCubit, ManualBookingState>(
      listenWhen: (a, b) => !a.done && b.done,
      listener: (context, state) {
        AppTopSnackBar.showSuccess(
          context,
          'venue.manual.saved_${state.payment.name}'.tr(context: context),
        );
        Navigator.of(context).pop(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'venue.manual.title'.tr(context: context),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
            child: ManualBookingFormWidget(
              venue: venue,
              initialName: customerName ?? '',
              initialPhone: customerPhone ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
