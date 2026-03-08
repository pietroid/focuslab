part of 'drag_grid_bloc.dart';

class DragGridState {
  const DragGridState({
    this.startTime,
    this.currentTime,
    this.completedStart,
    this.completedEnd,
  });

  final DateTime? startTime;
  final DateTime? currentTime;

  /// Set when a drag completes with a valid range. Cleared after the UI
  /// consumes it by dispatching DragResultConsumed.
  final DateTime? completedStart;
  final DateTime? completedEnd;

  bool get isDragging => startTime != null;
  bool get hasCompleted => completedStart != null && completedEnd != null;

  DragGridState copyWith({DateTime? startTime, DateTime? currentTime}) =>
      DragGridState(
        startTime: startTime ?? this.startTime,
        currentTime: currentTime ?? this.currentTime,
        completedStart: completedStart,
        completedEnd: completedEnd,
      );

  DragGridState cleared() => const DragGridState();
}
