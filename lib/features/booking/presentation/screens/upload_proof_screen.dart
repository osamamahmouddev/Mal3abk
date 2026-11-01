import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../data/models/create_booking_response_model.dart';
import '../cubit/proof_upload_cubit.dart';
import '../widgets/upload_proof_bloc_builder.dart';

class UploadProofScreen extends StatelessWidget {
  const UploadProofScreen({
    this.bookingId,
    this.booking,
    this.depositAmount,
    super.key,
  });

  final String? bookingId;
  final CreateBookingResponseModel? booking;
  final double? depositAmount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProofUploadCubit>(
      create: (_) => sl<ProofUploadCubit>(),
      child: UploadProofBlocBuilder(
        bookingId: bookingId,
        booking: booking,
        depositAmount: depositAmount,
      ),
    );
  }
}
