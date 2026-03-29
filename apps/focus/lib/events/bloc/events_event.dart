part of 'events_bloc.dart';

sealed class EventsEvent {}

final class EventsStarted extends EventsEvent {}

final class EventAdded extends EventsEvent {
  EventAdded({required this.event});

  final Event event;
}

final class EventUpdated extends EventsEvent {
  EventUpdated({required this.event});

  final Event event;
}

final class EventDeleted extends EventsEvent {
  EventDeleted({required this.eventId});

  final String eventId;
}

final class EventAddedQuickly extends EventsEvent {
  EventAddedQuickly({
    required this.name,
    required this.durationMinutes,
    required this.isFixed,
  });

  final String name;
  final int durationMinutes;
  final bool isFixed;
}
