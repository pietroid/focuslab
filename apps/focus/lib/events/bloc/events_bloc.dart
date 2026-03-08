import 'package:bloc/bloc.dart';
import 'package:focus/events/models/event_model.dart';
import 'package:focus/events/repository/events_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc({required EventsRepository eventsRepository})
      : _eventsRepository = eventsRepository,
        super(const EventsState()) {
    on<EventsStarted>(_onEventsStarted);
    on<EventAdded>(_onEventAdded);
    on<EventUpdated>(_onEventUpdated);
    on<EventDeleted>(_onEventDeleted);
  }

  final EventsRepository _eventsRepository;

  Future<void> _onEventsStarted(
    EventsStarted event,
    Emitter<EventsState> emit,
  ) async {
    final events = await _eventsRepository.getEvents();
    emit(state.copyWith(events: events));
  }

  Future<void> _onEventAdded(
    EventAdded event,
    Emitter<EventsState> emit,
  ) async {
    final events = [...state.events, event.event];
    emit(state.copyWith(events: events));
    await _eventsRepository.saveEvents(events);
  }

  Future<void> _onEventUpdated(
    EventUpdated event,
    Emitter<EventsState> emit,
  ) async {
    final events = state.events
        .map((e) => e.id == event.event.id ? event.event : e)
        .toList();
    emit(state.copyWith(events: events));
    await _eventsRepository.saveEvents(events);
  }

  Future<void> _onEventDeleted(
    EventDeleted event,
    Emitter<EventsState> emit,
  ) async {
    final events = state.events.where((e) => e.id != event.eventId).toList();
    emit(state.copyWith(events: events));
    await _eventsRepository.saveEvents(events);
  }
}
