part of 'drag_handler_bloc.dart';

enum DragMode { creatingEvent, movingEvent, resizingEvent }

sealed class DragHandlerEvent {
  const DragHandlerEvent();
}

class DragHandlerGestureStarted extends DragHandlerEvent {
  const DragHandlerGestureStarted({
    required this.mode,
    required this.time,
    this.eventId,
    this.eventStart,
    this.eventEnd,
  });

  final DragMode mode;

  /// For create: the pointer time at hold. For move: pointer time (used to
  /// compute grab offset). For resize: not used (eventEnd is initial end).
  final DateTime time;

  /// Non-null for move and resize.
  final String? eventId;
  final DateTime? eventStart;
  final DateTime? eventEnd;
}

class DragHandlerDragUpdated extends DragHandlerEvent {
  const DragHandlerDragUpdated({required this.time});

  final DateTime time;
}

class DragHandlerDragEnded extends DragHandlerEvent {
  const DragHandlerDragEnded();
}

class DragHandlerResultConsumed extends DragHandlerEvent {
  const DragHandlerResultConsumed();
}
