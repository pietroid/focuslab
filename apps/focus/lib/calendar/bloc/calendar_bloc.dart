import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc({required DateTime now}) : super(CalendarState(now: now)) {
    on<SecondTicked>(_onSecondTicked);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(SecondTicked(now: DateTime.now())),
    );
  }

  late final Timer _timer;

  void _onSecondTicked(SecondTicked event, Emitter<CalendarState> emit) {
    emit(CalendarState(now: event.now));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
