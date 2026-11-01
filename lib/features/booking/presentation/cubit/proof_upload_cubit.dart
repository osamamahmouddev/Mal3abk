import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../domain/use_cases/submit_booking_proof_use_case.dart';
import 'proof_upload_state.dart';

class ProofUploadCubit extends Cubit<ProofUploadState> {
  ProofUploadCubit({required this.submitBookingProofUseCase})
    : super(const ProofUploadInitial());

  final SubmitBookingProofUseCase submitBookingProofUseCase;

  Future<bool> uploadProof({
    required String bookingId,
    required List<int> imageBytes,
    required String contentType,
    String? notes,
  }) async {
    emit(const ProofUploadLoading());

    final result = await submitBookingProofUseCase(
      bookingId: bookingId,
      imageBytes: imageBytes,
      contentType: contentType,
      notes: notes,
    );

    return result.when(
      success: (_) {
        emit(
          ProofUploadSuccess(
            bookingId: bookingId,
            message: 'تم إرسال إيصال الدفع بنجاح وهو قيد المراجعة الآن.',
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(ProofUploadError(failure.message));
        return false;
      },
    );
  }
}
