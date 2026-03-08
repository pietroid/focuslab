part of 'events_bloc.dart';

class EventsState {
  const EventsState({this.events = const []});

  final List<Event> events;

  EventsState copyWith({List<Event>? events}) =>
      EventsState(events: events ?? this.events);
}
