import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/utils/image_sanitizer.dart';
import 'package:mal3abk/features/booking/data/models/upload_ticket_model.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import 'package:mal3abk/features/booking/domain/use_cases/submit_booking_proof_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';

class MockBookingRepo extends Mock implements BookingRepo {}

void main() {
  late MockBookingRepo repo;
  late SubmitBookingProofUseCase useCase;

  setUp(() {
    repo = MockBookingRepo();
    useCase = SubmitBookingProofUseCase(bookingRepo: repo);
  });

  test('never uploads a file that is not a photo', () async {
    final result = await useCase(
      bookingId: 'b-1',
      imageBytes: List.filled(64, 0x41),
    );

    expect(result, isFailureWith('errors.media.invalid_image'));
    verifyZeroInteractions(repo);
  });

  test('uploads a cleaned JPEG and submits it under its media id', () async {
    const ticket = UploadTicketModel(
      mediaId: 'media-1',
      uploadUrl: '/api/v1/media/uploads/media-1?token=t',
      expiresAtUtc: '2026-11-05T10:15:00Z',
    );
    when(
      () => repo.getProofUploadUrl('b-1'),
    ).thenAnswer((_) async => const ApiResult.success(ticket));
    when(
      () => repo.uploadMediaFile(
        uploadUrl: ticket.uploadUrl,
        bytes: any(named: 'bytes'),
        contentType: ImageSanitizer.contentType,
      ),
    ).thenAnswer((_) async => const ApiResult.success(null));
    when(
      () => repo.submitProof(id: 'b-1', mediaId: 'media-1', notes: '0101'),
    ).thenAnswer((_) async => const ApiResult.success(null));

    final receipt = img.encodePng(img.Image(width: 20, height: 20));
    final result = await useCase(
      bookingId: 'b-1',
      imageBytes: receipt,
      notes: '0101',
    );

    expect(result, isA<Success<void>>());
    final uploaded =
        verify(
              () => repo.uploadMediaFile(
                uploadUrl: ticket.uploadUrl,
                bytes: captureAny(named: 'bytes'),
                contentType: ImageSanitizer.contentType,
              ),
            ).captured.single
            as List<int>;
    expect(uploaded.take(3), [0xFF, 0xD8, 0xFF]);
    expect(Uint8List.fromList(uploaded), isNot(receipt));
  });
}
