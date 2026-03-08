import 'package:bloc/bloc.dart';

part 'drag_grid_event.dart';
part 'drag_grid_state.dart';

class DragGridBloc extends Bloc<DragGridEvent, DragGridState> {
  DragGridBloc() : super(const DragGridState()) {
    on<DragStarted>(_onDragStarted);
    on<DragUpdated>(_onDragUpdated);
    on<DragEnded>(_onDragEnded);
    on<DragResultConsumed>(_onDragResultConsumed);
  }

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
        emit(
          DragGridState(
            completedStart: actualStart,
            completedEnd: actualEnd,
          ),
        );
        return;
      }
    }
    emit(state.cleared());
  }

  void _onDragResultConsumed(
    DragResultConsumed event,
    Emitter<DragGridState> emit,
  ) {
    emit(state.cleared());
  }
}
