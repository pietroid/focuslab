part of 'event_preview_bloc.dart';

enum EventPreviewStatus { idle, editing, confirmed }

class EventPreviewState {
  const EventPreviewState({
    this.status = EventPreviewStatus.idle,
    this.eventId,
    this.startTime,
    this.endTime,
    this.name = '',
  });

  final EventPreviewStatus status;

  /// Non-null when editing an existing event; null when creating a new one.
  final String? eventId;

  final DateTime? startTime;
  final DateTime? endTime;
  final String name;

  bool get isActive => status == EventPreviewStatus.editing;
  bool get isConfirmed => status == EventPreviewStatus.confirmed;

  EventPreviewState copyWith({
    EventPreviewStatus? status,
    String? name,
  }) => EventPreviewState(
    status: status ?? this.status,
    eventId: eventId,
    startTime: startTime,
    endTime: endTime,
    name: name ?? this.name,
  );
}
