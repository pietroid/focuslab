part of 'time_bloc.dart';

@immutable
class TimeState {
  const TimeState({
    required this.now,
    required this.grid,
  });

  final DateTime now;

  final Grid grid;
}
