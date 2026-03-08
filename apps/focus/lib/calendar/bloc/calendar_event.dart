part of 'calendar_bloc.dart';

@immutable
sealed class CalendarEvent {
  const CalendarEvent();
}

class SecondTicked extends CalendarEvent {
  const SecondTicked({required this.now});

  final DateTime now;
}
