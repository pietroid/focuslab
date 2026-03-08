import 'package:bloc/bloc.dart';
import 'package:focus/events/models/event_model.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(const EventsState()) {
    on<EventAdded>(_onEventAdded);
    on<EventUpdated>(_onEventUpdated);
  }

  void _onEventAdded(EventAdded event, Emitter<EventsState> emit) {
    emit(state.copyWith(events: [...state.events, event.event]));
  }

  void _onEventUpdated(EventUpdated event, Emitter<EventsState> emit) {
    emit(state.copyWith(
      events: state.events
          .map((e) => e.id == event.event.id ? event.event : e)
          .toList(),
    ));
  }
}
