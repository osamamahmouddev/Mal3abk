/// When the player wants to play, from the home "when do you want to play?"
/// card: a day within the next week and a kick-off hour, both Cairo time.
class PlayTimeModel {
  const PlayTimeModel({required this.dayOffset, required this.hour});

  /// Days offered: today and the six after it.
  static const int days = 7;

  /// The usual evening kick-off suggested when it is still ahead.
  static const int eveningHour = 20;

  /// 0 is today in Cairo, 1 tomorrow, up to [days] - 1.
  final int dayOffset;

  /// 0-23, Cairo time.
  final int hour;

  /// Hours that can still be played on [dayOffset]: only the ones after the
  /// current hour today, every hour on later days.
  static List<int> hoursFor(int dayOffset, DateTime cairoNow) => [
    for (var h = dayOffset == 0 ? cairoNow.hour + 1 : 0; h < 24; h++) h,
  ];

  /// 8 PM today, the next hour once that has passed, and 8 PM tomorrow when
  /// nothing is left today.
  static PlayTimeModel suggest(DateTime cairoNow) {
    final next = cairoNow.hour + 1;
    if (next <= eveningHour) {
      return const PlayTimeModel(dayOffset: 0, hour: eveningHour);
    }
    if (next < 24) return PlayTimeModel(dayOffset: 0, hour: next);
    return const PlayTimeModel(dayOffset: 1, hour: eveningHour);
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
