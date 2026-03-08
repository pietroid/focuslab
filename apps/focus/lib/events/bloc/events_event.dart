part of 'events_bloc.dart';

sealed class EventsEvent {}

final class EventAdded extends EventsEvent {
  EventAdded({required this.event});

  final Event event;
}
