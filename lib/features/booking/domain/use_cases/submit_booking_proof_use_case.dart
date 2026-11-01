import '../../../../core/network/api_result.dart';
import '../../data/models/upload_ticket_model.dart';
import '../repos/booking_repo.dart';

class SubmitBookingProofUseCase {
  const SubmitBookingProofUseCase({required this.bookingRepo});

  final BookingRepo bookingRepo;

  Future<ApiResult<dynamic>> call({
    required String bookingId,
    required List<int> imageBytes,
    required String contentType,
    String? notes,
  }) async {
    // Step 1: Request upload ticket
    final ticketResult = await bookingRepo.getProofUploadUrl(bookingId);
    if (ticketResult is ApiFailure<UploadTicketModel>) {
      return ApiResult.failure(ticketResult.failure);
    }
    final ticket = (ticketResult as Success<UploadTicketModel>).data;

    // Step 2: Upload file bytes
    final uploadResult = await bookingRepo.uploadMediaFile(
      uploadUrl: ticket.uploadUrl,
      bytes: imageBytes,
      contentType: contentType,
    );
    if (uploadResult is ApiFailure<void>) {
      return ApiResult.failure(uploadResult.failure);
    }

    // Step 3: Submit proof
    return bookingRepo.submitProof(
      id: bookingId,
      mediaId: ticket.id,
      notes: notes,
    );
  }
}
