import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/app/home/view/home_view.dart';
import 'package:focus/calendar/bloc/calendar_bloc.dart';
import 'package:focus/events/bloc/events_bloc.dart';
import 'package:focus/events/repository/events_repository.dart';

/// {@template home_page}
/// The [HomePage] is the main page of the app.
///
/// It contains all the configurations for the entire app to run.
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CalendarBloc(now: DateTime.now())),
          BlocProvider(
            create:
                (ctx) =>
                    EventsBloc(eventsRepository: ctx.read<EventsRepository>())
                      ..add(EventsStarted()),
          ),
        ],
        child: const HomeView(),
      ),
    );
  }
}
