part of 'event_preview_bloc.dart';

enum EventPreviewStatus { idle, editing, confirmed }

class EventPreviewState {
  const EventPreviewState({
    this.status = EventPreviewStatus.idle,
    this.startTime,
    this.endTime,
    this.name = '',
  });

  final EventPreviewStatus status;
  final DateTime? startTime;
  final DateTime? endTime;
  final String name;

  bool get isActive => status == EventPreviewStatus.editing;
  bool get isConfirmed => status == EventPreviewStatus.confirmed;

  EventPreviewState copyWith({
    EventPreviewStatus? status,
    DateTime? startTime,
    DateTime? endTime,
    String? name,
  }) => EventPreviewState(
    status: status ?? this.status,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    name: name ?? this.name,
  );
}
