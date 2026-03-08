part of 'drag_handler_bloc.dart';

class DragHandlerState {
  const DragHandlerState({
    this.mode,
    this.startTime,
    this.currentTime,
    this.eventId,
    this.grabOffset,
    this.eventDuration,
    this.currentStart,
    this.currentEnd,
    this.completedMode,
    this.completedStart,
    this.completedEnd,
    this.completedEventId,
  });

  /// Active drag mode. Null when idle.
  final DragMode? mode;

  /// Create: anchor time.
  /// Resize: fixed event start (does not change during drag).
  final DateTime? startTime;

  /// Create: current cursor time.
  final DateTime? currentTime;

  /// Move / resize: id of the event being manipulated.
  final String? eventId;

  /// Move: how far into the event the pointer grabbed (pointer − eventStart).
  final Duration? grabOffset;

  /// Move: event duration, preserved throughout the drag.
  final Duration? eventDuration;

  /// Move: current computed start / end positions.
  /// Resize: currentStart is unused; currentEnd is the dragged end time.
  final DateTime? currentStart;
  final DateTime? currentEnd;

  // ── one-shot completion results ─────────────────────────────────────────

  final DragMode? completedMode;
  final DateTime? completedStart;
  final DateTime? completedEnd;

  /// Non-null for move / resize completions.
  final String? completedEventId;

  bool get isDragging => mode != null;
  bool get hasCompleted => completedMode != null;

  DragHandlerState cleared() => const DragHandlerState();
}
