import 'package:bloc/bloc.dart';

part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  ActionBloc() : super(const ActionState()) {
    on<ActionFocused>(_onFocused);
    on<ActionUnfocused>(_onUnfocused);
    on<ActionTextChanged>(_onTextChanged);
    on<ActionDurationChanged>(_onDurationChanged);
    on<ActionFixedChanged>(_onFixedChanged);
    on<ActionSubmitted>(_onSubmitted);
  }

  void _onFocused(ActionFocused event, Emitter<ActionState> emit) {
    emit(state.copyWith(isExpanded: true));
  }

  void _onUnfocused(ActionUnfocused event, Emitter<ActionState> emit) {
    if (state.text.isEmpty) {
      emit(state.copyWith(isExpanded: false));
    }
  }

  void _onTextChanged(ActionTextChanged event, Emitter<ActionState> emit) {
    emit(state.copyWith(text: event.text));
  }

  void _onDurationChanged(
    ActionDurationChanged event,
    Emitter<ActionState> emit,
  ) {
    emit(state.copyWith(duration: event.duration));
  }

  void _onFixedChanged(ActionFixedChanged event, Emitter<ActionState> emit) {
    emit(state.copyWith(isFixed: event.isFixed));
  }

  void _onSubmitted(ActionSubmitted event, Emitter<ActionState> emit) {
    emit(const ActionState());
  }
}
