import 'package:bloc/bloc.dart';
import 'package:focus/events/events.dart';

part 'drag_grid_event.dart';
part 'drag_grid_state.dart';

class DragGridBloc extends Bloc<DragGridEvent, DragGridState> {
  DragGridBloc({required this.eventsBloc}) : super(const DragGridState()) {
    on<DragStarted>(_onDragStarted);
    on<DragUpdated>(_onDragUpdated);
    on<DragEnded>(_onDragEnded);
  }

  final EventsBloc eventsBloc;

  void _onDragStarted(DragStarted event, Emitter<DragGridState> emit) {
    emit(DragGridState(startTime: event.time, currentTime: event.time));
  }

  void _onDragUpdated(DragUpdated event, Emitter<DragGridState> emit) {
    emit(state.copyWith(currentTime: event.time));
  }

  void _onDragEnded(DragEnded event, Emitter<DragGridState> emit) {
    final start = state.startTime;
    if (start != null) {
      final actualStart = start.isBefore(event.time) ? start : event.time;
      final actualEnd = start.isBefore(event.time) ? event.time : start;
      if (actualStart != actualEnd) {
        eventsBloc.add(
          EventAdded(
            event: Event(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: 'New Event',
              startDate: actualStart,
              endDate: actualEnd,
            ),
          ),
        );
      }
    }
    emit(state.cleared());
  }
}
