import 'package:bloc/bloc.dart';

part 'drag_handler_event.dart';
part 'drag_handler_state.dart';

/// Unified drag handler bloc.
///
/// Tracks the gesture in progress (create / move / resize) and emits a
/// one-shot completed state when the drag ends.  The UI layer (BlocListeners
/// in HourlyGrid) is responsible for acting on the completed result and
/// dispatching [DragHandlerResultConsumed] to reset.
class DragHandlerBloc extends Bloc<DragHandlerEvent, DragHandlerState> {
  DragHandlerBloc() : super(const DragHandlerState()) {
    on<DragHandlerGestureStarted>(_onGestureStarted);
    on<DragHandlerDragUpdated>(_onDragUpdated);
    on<DragHandlerDragEnded>(_onDragEnded);
    on<DragHandlerResultConsumed>(_onResultConsumed);
  }

  void _onGestureStarted(
    DragHandlerGestureStarted event,
    Emitter<DragHandlerState> emit,
  ) {
    switch (event.mode) {
      case DragMode.creatingEvent:
        emit(
          DragHandlerState(
            mode: DragMode.creatingEvent,
            startTime: event.time,
            currentTime: event.time,
          ),
        );

      case DragMode.movingEvent:
        final grabOffset = event.time.difference(event.eventStart!);
        final duration = event.eventEnd!.difference(event.eventStart!);
        emit(
          DragHandlerState(
            mode: DragMode.movingEvent,
            eventId: event.eventId,
            grabOffset: grabOffset,
            eventDuration: duration,
            currentStart: event.eventStart,
            currentEnd: event.eventEnd,
          ),
        );

      case DragMode.resizingEvent:
        emit(
          DragHandlerState(
            mode: DragMode.resizingEvent,
            eventId: event.eventId,
            startTime: event.eventStart, // fixed — never changes
            currentEnd: event.eventEnd,  // initial end, updated on drag
          ),
        );
    }
  }

  void _onDragUpdated(
    DragHandlerDragUpdated event,
    Emitter<DragHandlerState> emit,
  ) {
    switch (state.mode) {
      case DragMode.creatingEvent:
        emit(
          DragHandlerState(
            mode: state.mode,
            startTime: state.startTime,
            currentTime: event.time,
          ),
        );

      case DragMode.movingEvent:
        final newStart = _computeMoveStart(event.time);
        emit(
          DragHandlerState(
            mode: state.mode,
            eventId: state.eventId,
            grabOffset: state.grabOffset,
            eventDuration: state.eventDuration,
            currentStart: newStart,
            currentEnd: newStart.add(state.eventDuration!),
          ),
        );

      case DragMode.resizingEvent:
        // End must not precede the fixed start.
        final newEnd =
            event.time.isBefore(state.startTime!)
                ? state.startTime!
                : event.time;
        emit(
          DragHandlerState(
            mode: state.mode,
            eventId: state.eventId,
            startTime: state.startTime,
            currentEnd: newEnd,
          ),
        );

      case null:
        break;
    }
  }

  void _onDragEnded(
    DragHandlerDragEnded event,
    Emitter<DragHandlerState> emit,
  ) {
    switch (state.mode) {
      case DragMode.creatingEvent:
        final anchor = state.startTime!;
        final cursor = state.currentTime!;
        final actualStart = anchor.isBefore(cursor) ? anchor : cursor;
        final actualEnd = anchor.isBefore(cursor) ? cursor : anchor;
        if (actualStart != actualEnd) {
          emit(
            DragHandlerState(
              completedMode: DragMode.creatingEvent,
              completedStart: actualStart,
              completedEnd: actualEnd,
            ),
          );
          return;
        }

      case DragMode.movingEvent:
        if (state.currentStart != null && state.currentEnd != null) {
          emit(
            DragHandlerState(
              completedMode: DragMode.movingEvent,
              completedEventId: state.eventId,
              completedStart: state.currentStart,
              completedEnd: state.currentEnd,
            ),
          );
          return;
        }

      case DragMode.resizingEvent:
        if (state.startTime != null && state.currentEnd != null) {
          emit(
            DragHandlerState(
              completedMode: DragMode.resizingEvent,
              completedEventId: state.eventId,
              completedStart: state.startTime,
              completedEnd: state.currentEnd,
            ),
          );
          return;
        }

      case null:
        break;
    }
    emit(const DragHandlerState());
  }

  void _onResultConsumed(
    DragHandlerResultConsumed event,
    Emitter<DragHandlerState> emit,
  ) {
    emit(const DragHandlerState());
  }

  DateTime _computeMoveStart(DateTime pointerTime) {
    final raw = pointerTime.subtract(state.grabOffset!);
    return DateTime(
      raw.year,
      raw.month,
      raw.day,
      raw.hour.clamp(0, 23),
      raw.minute.clamp(0, 59),
    );
  }
}
