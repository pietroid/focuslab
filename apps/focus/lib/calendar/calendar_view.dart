import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:focus/calendar/models/day_data.dart';
import 'package:focus/calendar/widgets/day_column.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

/// {@template calendar_view}
/// [CalendarView] is the most fundamental view for the entire focus app
///
/// It contains the classic calendar grid, with one column per day
/// and rows representing hours.
/// {@endtemplate}
class CalendarView extends StatefulWidget {
  /// {@macro calendar_view}
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarState();
}

class _CalendarState extends State<CalendarView> {
  late final LinkedScrollControllerGroup _scrollGroup;
  late final List<DateTime> _listOfDays;

  @override
  void initState() {
    super.initState();
    _scrollGroup = LinkedScrollControllerGroup();
    // TODO(any): replace by repository
    _listOfDays = List.generate(
      20,
      (index) => DateTime.now().add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Builds horizontal grid of days, with one column per day and
    /// rows representing hours.
    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final dayData = DayData.fromDay(_listOfDays[index]);
          return DayColumn(data: dayData, scrollGroup: _scrollGroup);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 0),
        itemCount: _listOfDays.length,
      ),
    );
  }
}
