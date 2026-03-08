part of 'drag_event_bloc.dart';

sealed class DragEventEvent {
  const DragEventEvent();
}

class EventDragStarted extends DragEventEvent {
  const EventDragStarted({
    required this.eventId,
    required this.eventStart,
    required this.eventEnd,
    required this.pointerTime,
  });

  final String eventId;
  final DateTime eventStart;
  final DateTime eventEnd;
  final DateTime pointerTime;
}

class EventDragUpdated extends DragEventEvent {
  const EventDragUpdated({required this.pointerTime});

  final DateTime pointerTime;
}

/// The drag is complete. The bloc uses its current position from the last
/// EventDragUpdated — no pointer position needed.
class EventDragEnded extends DragEventEvent {
  const EventDragEnded();
}

class EventDragResultConsumed extends DragEventEvent {
  const EventDragResultConsumed();
}
