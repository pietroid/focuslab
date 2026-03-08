import 'package:bloc/bloc.dart';

part 'drag_event_event.dart';
part 'drag_event_state.dart';

class DragEventBloc extends Bloc<DragEventEvent, DragEventState> {
  DragEventBloc() : super(const DragEventState()) {
    on<EventDragStarted>(_onEventDragStarted);
    on<EventDragUpdated>(_onEventDragUpdated);
    on<EventDragEnded>(_onEventDragEnded);
    on<EventDragResultConsumed>(_onEventDragResultConsumed);
  }

  void _onEventDragStarted(
    EventDragStarted event,
    Emitter<DragEventState> emit,
  ) {
    final grabOffset = event.pointerTime.difference(event.eventStart);
    final eventDuration = event.eventEnd.difference(event.eventStart);
    emit(
      DragEventState(
        draggingEventId: event.eventId,
        grabOffset: grabOffset,
        eventDuration: eventDuration,
        currentStart: event.eventStart,
        currentEnd: event.eventEnd,
      ),
    );
  }

  void _onEventDragUpdated(
    EventDragUpdated event,
    Emitter<DragEventState> emit,
  ) {
    emit(state.withPosition(
      newStart: _computeStart(event.pointerTime),
      newEnd: _computeEnd(event.pointerTime),
    ));
  }

  void _onEventDragEnded(
    EventDragEnded event,
    Emitter<DragEventState> emit,
  ) {
    emit(
      DragEventState(
        completedEventId: state.draggingEventId,
        completedStart: state.currentStart,
        completedEnd: state.currentEnd,
      ),
    );
  }

  void _onEventDragResultConsumed(
    EventDragResultConsumed event,
    Emitter<DragEventState> emit,
  ) {
    emit(state.cleared());
  }

  DateTime _computeStart(DateTime pointerTime) {
    final raw = pointerTime.subtract(state.grabOffset!);
    return DateTime(
      raw.year,
      raw.month,
      raw.day,
      raw.hour.clamp(0, 23),
      raw.minute.clamp(0, 59),
    );
  }

  DateTime _computeEnd(DateTime pointerTime) {
    return _computeStart(pointerTime).add(state.eventDuration!);
  }
}
