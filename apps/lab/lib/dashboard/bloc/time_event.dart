part of 'time_bloc.dart';

@immutable
sealed class TimeEvent {}

class TimeTicked extends TimeEvent {
  TimeTicked();
}
