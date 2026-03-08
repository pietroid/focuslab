part of 'drag_grid_bloc.dart';

class DragGridState {
  const DragGridState({this.startTime, this.currentTime});

  final DateTime? startTime;
  final DateTime? currentTime;

  bool get isDragging => startTime != null;

  DragGridState copyWith({DateTime? startTime, DateTime? currentTime}) =>
      DragGridState(
        startTime: startTime ?? this.startTime,
        currentTime: currentTime ?? this.currentTime,
      );

  DragGridState cleared() => const DragGridState();
}
