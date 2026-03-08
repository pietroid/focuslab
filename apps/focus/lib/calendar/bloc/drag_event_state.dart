part of 'drag_event_bloc.dart';

class DragEventState {
  const DragEventState({
    this.draggingEventId,
    this.grabOffset,
    this.eventDuration,
    this.currentStart,
    this.currentEnd,
    this.completedEventId,
    this.completedStart,
    this.completedEnd,
  });

  /// The id of the event currently being repositioned, if any.
  final String? draggingEventId;

  /// How far into the event the user grabbed it (pointer - eventStart).
  final Duration? grabOffset;

  /// Duration of the event being dragged (preserved for end-time computation).
  final Duration? eventDuration;

  final DateTime? currentStart;
  final DateTime? currentEnd;

  /// One-shot result — set when the drag completes, cleared after consumption.
  final String? completedEventId;
  final DateTime? completedStart;
  final DateTime? completedEnd;

  bool get isDragging => draggingEventId != null;
  bool get hasCompleted => completedEventId != null;

  DragEventState withPosition({
    required DateTime newStart,
    required DateTime newEnd,
  }) => DragEventState(
    draggingEventId: draggingEventId,
    grabOffset: grabOffset,
    eventDuration: eventDuration,
    currentStart: newStart,
    currentEnd: newEnd,
  );

  DragEventState cleared() => const DragEventState();
}
