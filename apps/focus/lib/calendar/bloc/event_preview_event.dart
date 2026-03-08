part of 'event_preview_bloc.dart';

sealed class EventPreviewEvent {
  const EventPreviewEvent();
}

class PreviewStarted extends EventPreviewEvent {
  const PreviewStarted({required this.startTime, required this.endTime});

  final DateTime startTime;
  final DateTime endTime;
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
