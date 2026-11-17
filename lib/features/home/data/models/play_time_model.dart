/// When the player wants to play, from the home "when do you want to play?"
/// card: a day within the next week and a kick-off hour, both Cairo time.
class PlayTimeModel {
  const PlayTimeModel({required this.dayOffset, required this.hour});

  /// Days offered: today and the six after it.
  static const int days = 7;

  /// Hours nobody books (2 AM to 8 AM): never suggested on their own.
  static const int quietFrom = 2;
  static const int quietUntil = 9;

  /// 0 is today in Cairo, 1 tomorrow, up to [days] - 1.
  final int dayOffset;

  /// 0-23, Cairo time.
  final int hour;

  /// Hours that can still be played on [dayOffset]: only the ones after the
  /// current hour today, every hour on later days.
  static List<int> hoursFor(int dayOffset, DateTime cairoNow) => [
    for (var h = dayOffset == 0 ? cairoNow.hour + 1 : 0; h < 24; h++) h,
  ];

  /// The first time worth offering, in this order:
  /// 1. [usualHour], the hour this player last searched for, at its next
  ///    occurrence (today if still ahead, else tomorrow);
  /// 2. [freeSlotCairo], the earliest free slot nearby, so the search finds
  ///    a pitch, when it falls within the week;
  /// 3. the next hour still ahead, skipping the quiet hours (2-8 AM).
  static PlayTimeModel suggest(
    DateTime cairoNow, {
    int? usualHour,
    DateTime? freeSlotCairo,
  }) {
    if (usualHour != null && usualHour >= 0 && usualHour < 24) {
      return PlayTimeModel(
        dayOffset: usualHour > cairoNow.hour ? 0 : 1,
        hour: usualHour,
      );
    }

    if (freeSlotCairo != null) {
      final today = DateTime(cairoNow.year, cairoNow.month, cairoNow.day);
      final slotDay = DateTime(
        freeSlotCairo.year,
        freeSlotCairo.month,
        freeSlotCairo.day,
      );
      final offset = slotDay.difference(today).inDays;
      if (offset >= 0 &&
          offset < days &&
          hoursFor(offset, cairoNow).contains(freeSlotCairo.hour)) {
        return PlayTimeModel(dayOffset: offset, hour: freeSlotCairo.hour);
      }
    }

    final next = cairoNow.hour + 1;
    if (next >= 24) return const PlayTimeModel(dayOffset: 1, hour: quietUntil);
    if (next >= quietFrom && next < quietUntil) {
      return const PlayTimeModel(dayOffset: 0, hour: quietUntil);
    }
    return PlayTimeModel(dayOffset: 0, hour: next);
  }

  /// The same choice on another day. The hour is kept when it can still be
  /// played that day, otherwise the first one left is taken; a day with no
  /// hour left (late tonight) falls back to [suggest].
  PlayTimeModel onDay(int offset, DateTime cairoNow) {
    final hours = hoursFor(offset, cairoNow);
    if (hours.isEmpty) return suggest(cairoNow);
    return PlayTimeModel(
      dayOffset: offset,
      hour: hours.contains(hour) ? hour : hours.first,
    );
  }

  /// The calendar date chosen, counted from [today] (a Cairo date).
  DateTime dayFrom(DateTime today) =>
      DateTime(today.year, today.month, today.day + dayOffset);

  @override
  bool operator ==(Object other) =>
      other is PlayTimeModel &&
      other.dayOffset == dayOffset &&
      other.hour == hour;

  @override
  int get hashCode => Object.hash(dayOffset, hour);
}
