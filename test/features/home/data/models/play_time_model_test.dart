import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/home/data/models/play_time_model.dart';

DateTime at(int hour, [int minute = 0]) => DateTime(2026, 11, 14, hour, minute);

void main() {
  group('the suggested time', () {
    final cases = {
      'early morning → 8 PM today': (at(6), 0, 20),
      'afternoon → 8 PM today': (at(15, 40), 0, 20),
      '7:59 PM → 8 PM today': (at(19, 59), 0, 20),
      '8:10 PM → 9 PM today': (at(20, 10), 0, 21),
      '10:30 PM → 11 PM today': (at(22, 30), 0, 23),
      'after 11 PM → 8 PM tomorrow': (at(23, 5), 1, 20),
    };
    cases.forEach((label, value) {
      final (now, day, hour) = value;
      test(label, () {
        expect(
          PlayTimeModel.suggest(now),
          PlayTimeModel(dayOffset: day, hour: hour),
        );
      });
    });
  });

  group('the hours offered', () {
    test('today: only the hours still ahead', () {
      expect(PlayTimeModel.hoursFor(0, at(20, 30)), [21, 22, 23]);
    });

    test('today right on the hour: that hour has started, so not offered', () {
      expect(PlayTimeModel.hoursFor(0, at(22)), [23]);
    });

    test('today after 11 PM: nothing left', () {
      expect(PlayTimeModel.hoursFor(0, at(23, 30)), isEmpty);
    });

    test('later days: every hour', () {
      final hours = PlayTimeModel.hoursFor(3, at(23, 30));
      expect(hours, hasLength(24));
      expect(hours.first, 0);
      expect(hours.last, 23);
    });
  });

  group('moving the choice to another day', () {
    const evening = PlayTimeModel(dayOffset: 2, hour: 20);

    test('keeps the hour when it can still be played', () {
      expect(
        evening.onDay(0, at(10)),
        const PlayTimeModel(dayOffset: 0, hour: 20),
      );
    });

    test('takes the first hour left when the hour has passed today', () {
      expect(
        evening.onDay(0, at(21, 15)),
        const PlayTimeModel(dayOffset: 0, hour: 22),
      );
    });

    test('a later day keeps any hour', () {
      expect(
        const PlayTimeModel(dayOffset: 0, hour: 23).onDay(5, at(22, 30)),
        const PlayTimeModel(dayOffset: 5, hour: 23),
      );
    });

    test('today with nothing left falls back to tomorrow evening', () {
      expect(evening.onDay(0, at(23, 40)), PlayTimeModel.suggest(at(23, 40)));
      expect(evening.onDay(0, at(23, 40)).dayOffset, 1);
    });
  });

  group('the calendar date', () {
    test('today', () {
      expect(
        const PlayTimeModel(
          dayOffset: 0,
          hour: 20,
        ).dayFrom(DateTime(2026, 11, 14)),
        DateTime(2026, 11, 14),
      );
    });

    test('crosses into the next month', () {
      expect(
        const PlayTimeModel(
          dayOffset: 3,
          hour: 20,
        ).dayFrom(DateTime(2026, 11, 29)),
        DateTime(2026, 12, 2),
      );
    });

    test('crosses into the next year', () {
      expect(
        const PlayTimeModel(
          dayOffset: 6,
          hour: 20,
        ).dayFrom(DateTime(2026, 12, 28)),
        DateTime(2027, 1, 3),
      );
    });

    test('a week is offered', () => expect(PlayTimeModel.days, 7));
  });
}
