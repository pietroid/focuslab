import 'package:bloc/bloc.dart';

part 'event_preview_event.dart';
part 'event_preview_state.dart';

class EventPreviewBloc extends Bloc<EventPreviewEvent, EventPreviewState> {
  EventPreviewBloc() : super(const EventPreviewState()) {
    on<PreviewStarted>(_onPreviewStarted);
    on<PreviewNameChanged>(_onPreviewNameChanged);
    on<PreviewConfirmed>(_onPreviewConfirmed);
    on<PreviewCancelled>(_onPreviewCancelled);
    on<PreviewResultConsumed>(_onPreviewResultConsumed);
  }

  void _onPreviewStarted(
    PreviewStarted event,
    Emitter<EventPreviewState> emit,
  ) {
    emit(
      EventPreviewState(
        status: EventPreviewStatus.editing,
        startTime: event.startTime,
        endTime: event.endTime,
      ),
    );
  }

  void _onPreviewNameChanged(
    PreviewNameChanged event,
    Emitter<EventPreviewState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onPreviewConfirmed(
    PreviewConfirmed event,
    Emitter<EventPreviewState> emit,
  ) {
    emit(state.copyWith(status: EventPreviewStatus.confirmed));
  }

  void _onPreviewCancelled(
    PreviewCancelled event,
    Emitter<EventPreviewState> emit,
  ) {
    emit(const EventPreviewState());
  }

  void _onPreviewResultConsumed(
    PreviewResultConsumed event,
    Emitter<EventPreviewState> emit,
  ) {
    emit(const EventPreviewState());
  }
}
