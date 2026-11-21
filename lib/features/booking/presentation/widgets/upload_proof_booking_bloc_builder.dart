import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_state_widget.dart';
import '../cubit/booking_details_cubit.dart';
import '../cubit/booking_details_state.dart';
import 'upload_proof_bloc_builder.dart';
import 'upload_proof_skeleton_widget.dart';

class UploadProofBookingBlocBuilder extends StatelessWidget {
  const UploadProofBookingBlocBuilder({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDetailsCubit, BookingDetailsState>(
      builder: (context, state) => switch (state) {
        BookingDetailsSuccess(:final booking)
            when booking.allowedActions.canUploadProof =>
          UploadProofBlocBuilder(booking: booking),
        BookingDetailsSuccess() => CustomStateWidget(
          title: 'booking.upload.closed'.tr(context: context),
          description: '',
        ),
        BookingDetailsError(:final message) => CustomStateWidget(
          title: message.tr(context: context),
          description: '',
          actionText: 'common.retry'.tr(context: context),
          onActionTap: () =>
              context.read<BookingDetailsCubit>().load(bookingId),
        ),
        _ => const UploadProofSkeletonWidget(),
      },
    );
  }
}
