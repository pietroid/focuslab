import 'package:focus/calendar/utils/calendar_formatter.dart';

/// Model representing a day in the calendar,
/// containing information about the day's name, hours, and active time range.
class DayData {
  /// Constructs a [DayData] instance with the given parameters.
  DayData({
    required this.name,
    required this.hours,
    required this.dayOfTheMonth,
    required this.activeStartTime,
    required this.activeEndTime,
  });

  /// Factory constructor to create a [DayData]
  /// instance from a [DateTime] object.
  factory DayData.fromDay(DateTime day) {
    final name = _getDayName(day.weekday);
    final dayOfTheMonth = day.dayOfTheMonth();

    final hours = List.generate(
      24,
      (index) => DateTime(day.year, day.month, day.day, index),
    );
    return DayData(
      name: name,
      dayOfTheMonth: dayOfTheMonth,
      hours: hours,
      activeStartTime: DateTime(day.year, day.month, day.day, 6),
      activeEndTime: DateTime(day.year, day.month, day.day, 23),
    );
  }

  /// Name of the day, e.g. "Monday", "Tuesday", etc.
  final String name;

  /// Day of the month, e.g. "01/04", "02/04", etc.
  final String dayOfTheMonth;

  /// List of hours in the day, e.g. ["06:00", "07:00", ..., "23:00"].
  final List<DateTime> hours;

  /// Start time of the active day, e.g. "06:00".
  final DateTime activeStartTime;

  /// End time of the active day, e.g. "23:00".
  final DateTime activeEndTime;

  List<DateTime> get activeHours {
    return hours
        .where(
          (hour) =>
              hour.isAfter(activeStartTime) && hour.isBefore(activeEndTime),
        )
        .toList();
  }

  static String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'segunda';
      case DateTime.tuesday:
        return 'terça';
      case DateTime.wednesday:
        return 'quarta';
      case DateTime.thursday:
        return 'quinta';
      case DateTime.friday:
        return 'sexta';
      case DateTime.saturday:
        return 'sábado';
      case DateTime.sunday:
        return 'domingo';
      default:
        return '';
    }
  }

  /// Creates a copy of this [DayData] with
  /// the given fields replaced by new values.
  DayData copyWith({
    String? name,
    String? dayOfTheMonth,
    List<DateTime>? hours,
    DateTime? activeStartTime,
    DateTime? activeEndTime,
  }) {
    return DayData(
      name: name ?? this.name,
      dayOfTheMonth: dayOfTheMonth ?? this.dayOfTheMonth,
      hours: hours ?? this.hours,
      activeStartTime: activeStartTime ?? this.activeStartTime,
      activeEndTime: activeEndTime ?? this.activeEndTime,
    );
  }
}
