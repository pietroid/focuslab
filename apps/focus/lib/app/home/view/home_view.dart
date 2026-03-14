import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:focus/action/action_view.dart';
import 'package:focus/calendar/calendar_view.dart';
import 'package:focus/pending/pending_view.dart';

/// {@template home_view}
/// The [HomeView] is the main view of the app, it contains the calendar and
/// all the other sub-views.
/// {@endtemplate}
class HomeView extends StatelessWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlobalScaffold(
      body: Stack(
        children: [
          /// Calendar view is the most basic in the sense of being the
          /// ground of the entire app, so it is the one at the
          /// bottom of the stack.
          CalendarView(),

          /// Pending view is the one where pending events/actions are shown
          PendingView(),

          /// More view can be added as intermediate ones.
          /// ....

          /// Action view is the entrypoint for the primary interactions
          /// with the user and must be above everything else.
          ActionView(),
        ],
      ),
    );
  }
}
