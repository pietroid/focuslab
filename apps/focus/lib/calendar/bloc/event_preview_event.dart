part of 'event_preview_bloc.dart';

sealed class EventPreviewEvent {
  const EventPreviewEvent();
}

/// Fired when a new-event drag completes — opens a blank name field.
class PreviewStarted extends EventPreviewEvent {
  const PreviewStarted({required this.startTime, required this.endTime});

  final DateTime startTime;
  final DateTime endTime;
}

/// Fired when the user taps an existing event — opens it for editing.
class EventEditStarted extends EventPreviewEvent {
  const EventEditStarted({
    required this.eventId,
    required this.startTime,
    required this.endTime,
    required this.name,
  });

  final String eventId;
  final DateTime startTime;
  final DateTime endTime;
  final String name;
}

class PreviewNameChanged extends EventPreviewEvent {
  const PreviewNameChanged({required this.name});

  final String name;
}

class PreviewConfirmed extends EventPreviewEvent {
  const PreviewConfirmed();
}

class PreviewCancelled extends EventPreviewEvent {
  const PreviewCancelled();
}

class PreviewResultConsumed extends EventPreviewEvent {
  const PreviewResultConsumed();
}
