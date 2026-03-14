import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:focus/calendar/calendar_view.dart';

/// {@template home_view}
/// The [HomeView] is the main view of the app, it contains the calendar and
/// all the other sub-views.
/// {@endtemplate}
class HomeView extends StatelessWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlobalScaffold(body: CalendarView());
  }
}
