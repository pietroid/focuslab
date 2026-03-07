import 'package:flutter/widgets.dart';
import 'package:focus/calendar/widgets/day_column.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final LinkedScrollControllerGroup _scrollGroup;
  late final List<DateTime> _listOfDays;

  @override
  void initState() {
    super.initState();
    _scrollGroup = LinkedScrollControllerGroup();
    _listOfDays = List.generate(
      20,
      (index) => DateTime.now().add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final dayData = DayData.fromDay(_listOfDays[index]);
        return DayColumn(data: dayData, scrollGroup: _scrollGroup);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 0),
      itemCount: _listOfDays.length,
    );
  }
}

class DayData {
  DayData({
    required this.name,
    required this.hours,
    required this.dayOfTheMonth,
    required this.activeStartTime,
    required this.activeEndTime,
  });

  factory DayData.fromDay(DateTime day) {
    final name = _getDayName(day.weekday);
    final dayOfTheMonth =
        '${day.day.toString().padLeft(2, '0')}/${day.month.toString().padLeft(2, '0')}';
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
        return 'Segunda';
      case DateTime.tuesday:
        return 'Terça';
      case DateTime.wednesday:
        return 'Quarta';
      case DateTime.thursday:
        return 'Quinta';
      case DateTime.friday:
        return 'Sexta';
      case DateTime.saturday:
        return 'Sábado';
      case DateTime.sunday:
        return 'Domingo';
      default:
        return '';
    }
  }

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
