import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_summary_model.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_my_bookings_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockBookingRepo extends Mock implements BookingRepo {}

void main() {
  late MockBookingRepo mockRepo;
  late GetMyBookingsUseCase getMyBookingsUseCase;

  setUp(() {
    mockRepo = MockBookingRepo();
    getMyBookingsUseCase = GetMyBookingsUseCase(bookingRepo: mockRepo);
  });

  const sampleList = PlayerBookingsPagedListModel(
    items: [],
    totalCount: 0,
    page: 1,
    pageSize: 10,
  );

  test('GetMyBookingsUseCase delegates to booking repo', () async {
    when(
      () => mockRepo.getMyBookings(tab: 'upcoming', page: 1, pageSize: 10),
    ).thenAnswer((_) async => const ApiResult.success(sampleList));

    final result = await getMyBookingsUseCase(
      tab: 'upcoming',
      page: 1,
      pageSize: 10,
    );

    expect(result, isA<Success<PlayerBookingsPagedListModel>>());
    verify(
      () => mockRepo.getMyBookings(tab: 'upcoming', page: 1, pageSize: 10),
    ).called(1);
  });
}
