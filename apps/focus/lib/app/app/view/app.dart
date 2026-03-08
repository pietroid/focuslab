import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/events/repository/events_repository.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({required this.router, required this.eventsRepository, super.key});

  final GoRouter router;
  final EventsRepository eventsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: eventsRepository,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        themeMode: ThemeMode.dark,
        darkTheme: AppTheme().themeData,
      ),
    );
  }
}
