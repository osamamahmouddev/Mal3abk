import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/submit_booking_proof_use_case.dart';
import 'proof_upload_state.dart';

class ProofUploadCubit extends Cubit<ProofUploadState>
    with SafeEmitCubitMixin<ProofUploadState> {
  ProofUploadCubit({required this.submitBookingProofUseCase})
    : super(const ProofUploadInitial());

  final SubmitBookingProofUseCase submitBookingProofUseCase;

  Future<bool> uploadProof({
    required String bookingId,
    required List<int> imageBytes,
    String? notes,
  }) async {
    emitIfOpen(const ProofUploadLoading());

    final result = await submitBookingProofUseCase(
      bookingId: bookingId,
      imageBytes: imageBytes,
      notes: notes,
    );

    return result.when(
      success: (_) {
        emitIfOpen(
          ProofUploadSuccess(
            bookingId: bookingId,
            message: 'booking.upload.sent',
          ),
        );
        return true;
      },
      failure: (failure) {
        emitIfOpen(ProofUploadError(failure.message));
        return false;
      },
    );
  }
}
