import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:finance_repository/finance_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/new_home/widgets/fragment_provider.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function({
    required FinanceRepository financeRepository,
    required AnalogClockFragmentProvider clockFragmentProvider,
  }) builder,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here

  final financeRepository = FinanceRepository();
  await financeRepository.initialize();

  final clockFragmentProgram =
      await FragmentProgram.fromAsset('shaders/analog_clock_shader.frag');

  runApp(
    await builder(
      financeRepository: financeRepository,
      clockFragmentProvider: AnalogClockFragmentProvider(
        fragmentProgram: clockFragmentProgram,
      ),
    ),
  );
}
