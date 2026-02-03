import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(TimeState(now: DateTime.now())) {
    on<TimeTicked>((event, emit) {
      emit(TimeState(now: DateTime.now()));
    });

    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      add(TimeTicked());
    });
  }
}
