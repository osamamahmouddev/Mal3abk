import 'dart:typed_data';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/utils/image_sanitizer.dart';
import '../repos/booking_repo.dart';

/// Checks the receipt is a real photo and strips its metadata, then gets an
/// upload ticket, uploads it and submits it as the booking's payment proof.
class SubmitBookingProofUseCase {
  const SubmitBookingProofUseCase({
    required this.bookingRepo,
    this.imageSanitizer = const ImageSanitizer(),
  });

  final BookingRepo bookingRepo;
  final ImageSanitizer imageSanitizer;

  Future<ApiResult<void>> call({
    required String bookingId,
    required List<int> imageBytes,
    String? notes,
  }) async {
    final clean = await imageSanitizer.sanitize(Uint8List.fromList(imageBytes));
    if (clean == null) {
      return const ApiResult.failure(
        AppApiFailure(message: 'errors.media.invalid_image'),
      );
    }

    final ticketResult = await bookingRepo.getProofUploadUrl(bookingId);
    return ticketResult.when(
      success: (ticket) async {
        final upload = await bookingRepo.uploadMediaFile(
          uploadUrl: ticket.uploadUrl,
          bytes: clean,
          contentType: ImageSanitizer.contentType,
        );
        return upload.when(
          success: (_) => bookingRepo.submitProof(
            id: bookingId,
            mediaId: ticket.mediaId,
            notes: notes,
          ),
          failure: (failure) async => ApiResult.failure(failure),
        );
      },
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
