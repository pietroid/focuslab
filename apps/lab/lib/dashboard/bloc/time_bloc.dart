import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/dashboard/models/grid.dart';
import 'package:focuslab/dashboard/models/grid_configuration.dart';
import 'package:focuslab/dashboard/utils/time_grid_builder.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc({
    required this.configuration,
    required this.builder,
    required TickerProvider tickerProvider,
  })  : _tickerProvider = tickerProvider,
        super(
          TimeState(
            now: DateTime.now(),
            grid: builder.buildGrid(DateTime.now(), configuration),
          ),
        ) {
    _ticker = _tickerProvider.createTicker(_onTick)..start();
    on<TimeTicked>((event, emit) {
      final now = DateTime.now();

      final grid = builder.buildGrid(
        now,
        configuration,
      );

      emit(
        TimeState(
          now: now,
          grid: grid,
        ),
      );
    });
  }

  void _onTick(Duration elapsed) {
    add(TimeTicked());
  }

  void dispose() {
    _ticker.dispose();
  }

  final GridConfiguration configuration;
  final TimeGridBuilder builder;

  final TickerProvider _tickerProvider;
  late final Ticker _ticker;
}
