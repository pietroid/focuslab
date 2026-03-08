part of 'calendar_bloc.dart';

@immutable
///{@template calendar_state}
///State of the calendar
///{@endtemplate}
class CalendarState {
  /// {@macro calendar_state}
  const CalendarState({required this.now});

  /// The current date and time.
  final DateTime now;
}
