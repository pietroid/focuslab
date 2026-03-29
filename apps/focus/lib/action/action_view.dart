import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/action/bloc/action_bloc.dart';
import 'package:focus/action/widgets/action_add_circle_button.dart';
import 'package:focus/action/widgets/action_input_pill.dart';
import 'package:focus/action/widgets/action_media_player_pill.dart';
import 'package:focus/events/bloc/events_bloc.dart';
import 'package:focus/events/models/event_model.dart';

/// {@template action_view}
/// Entrypoint for the quick-add action of the Focus app.
///
/// Renders a floating pill anchored to the bottom of the screen. Its content
/// adapts to whether an [Event] is currently in progress:
///
/// - **No event in progress** — shows the [ActionInputPill] so the user can
///   type and schedule a task.
/// - **Event in progress** — shows the [ActionMediaPlayerPill] with live
///   elapsed/remaining time, plus an [ActionAddCircleButton] to the side.
///   Tapping the circle collapses the player and reveals the
///   [ActionInputPill], letting the user queue a new task while the current
///   one is still running. Dismissing the input (unfocus) returns to the
///   player.
/// {@endtemplate}
class ActionView extends StatelessWidget {
  /// {@macro action_view}
  const ActionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActionBloc(),
      child: const _ActionContent(),
    );
  }
}

class _ActionContent extends StatefulWidget {
  const _ActionContent();

  @override
  State<_ActionContent> createState() => _ActionContentState();
}

class _ActionContentState extends State<_ActionContent> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  Timer? _ticker;
  DateTime _now = DateTime.now();
  bool _isPaused = false;

  /// Whether the add-task input is visible while an event is in progress.
  ///
  /// `false` by default — toggled to `true` when the user taps the
  /// [ActionAddCircleButton], and reset to `false` when the text field loses
  /// focus (i.e. the user submits or dismisses).
  bool _showAddTask = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
    _startTicker();
  }

  void _startTicker() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isPaused && mounted) {
        setState(() => _now = DateTime.now());
      }
    });
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      context.read<ActionBloc>().add(ActionFocused());
    } else {
      context.read<ActionBloc>().add(ActionUnfocused());
      // Collapse the input back to the media player when dismissed.
      if (_showAddTask) setState(() => _showAddTask = false);
    }
  }

  void _onSubmit() {
    final actionState = context.read<ActionBloc>().state;
    final text = actionState.text.trim();
    if (text.isEmpty) return;

    context.read<EventsBloc>().add(
      EventAddedQuickly(
        name: text,
        durationMinutes: actionState.duration.minutes,
        isFixed: actionState.isFixed,
      ),
    );

    context.read<ActionBloc>().add(ActionSubmitted());
    _controller.clear();
    _focusNode.unfocus();
  }

  void _togglePause() => setState(() => _isPaused = !_isPaused);

  void _onAddTaskTapped() {
    setState(() => _showAddTask = true);
    // Request focus after the new frame renders the text field.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  Event? _currentEvent(List<Event> events) {
    return events
        .where((e) => e.startDate.isBefore(_now) && e.endDate.isAfter(_now))
        .firstOrNull;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, eventsState) {
        final inProgress = _currentEvent(eventsState.events);

        return BlocBuilder<ActionBloc, ActionState>(
          builder: (context, actionState) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
                child:
                    inProgress != null
                        ? _InProgressLayout(
                          inProgress: inProgress,
                          actionState: actionState,
                          controller: _controller,
                          focusNode: _focusNode,
                          now: _now,
                          isPaused: _isPaused,
                          showAddTask: _showAddTask,
                          onTogglePause: _togglePause,
                          onAddTaskTapped: _onAddTaskTapped,
                          onSubmit: _onSubmit,
                          onTapOutside: _focusNode.unfocus,
                        )
                        : TapRegion(
                          onTapOutside: (_) => _focusNode.unfocus(),
                          child: ActionInputPill(
                            controller: _controller,
                            focusNode: _focusNode,
                            onSubmit: _onSubmit,
                            state: actionState,
                          ),
                        ),
              ),
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// In-progress layout
// ---------------------------------------------------------------------------

/// Lays out the [ActionMediaPlayerPill] (or [ActionInputPill] when the user
/// wants to add a task) alongside the [ActionAddCircleButton].
///
/// Extracted to keep [_ActionContentState.build] readable. This widget is
/// private to this file and carries no business logic of its own.
class _InProgressLayout extends StatelessWidget {
  const _InProgressLayout({
    required this.inProgress,
    required this.actionState,
    required this.controller,
    required this.focusNode,
    required this.now,
    required this.isPaused,
    required this.showAddTask,
    required this.onTogglePause,
    required this.onAddTaskTapped,
    required this.onSubmit,
    required this.onTapOutside,
  });

  final Event inProgress;
  final ActionState actionState;
  final TextEditingController controller;
  final FocusNode focusNode;
  final DateTime now;
  final bool isPaused;
  final bool showAddTask;
  final VoidCallback onTogglePause;
  final VoidCallback onAddTaskTapped;
  final VoidCallback onSubmit;
  final VoidCallback onTapOutside;

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      // Both the pill and the circle are inside this region so that tapping
      // the circle while the input is open does not trigger an outside tap.
      onTapOutside: (_) => onTapOutside(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child:
                showAddTask
                    ? ActionInputPill(
                      key: const ValueKey('input'),
                      controller: controller,
                      focusNode: focusNode,
                      onSubmit: onSubmit,
                      state: actionState,
                    )
                    : ActionMediaPlayerPill(
                      key: const ValueKey('player'),
                      event: inProgress,
                      now: now,
                      isPaused: isPaused,
                      onTogglePause: onTogglePause,
                    ),
          ),
          const SizedBox(width: 8),
          ActionAddCircleButton(onTap: onAddTaskTapped),
        ],
      ),
    );
  }
}
