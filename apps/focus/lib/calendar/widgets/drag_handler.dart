import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/calendar/bloc/drag_handler_bloc.dart';
import 'package:focus/calendar/calendar.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';
import 'package:focus/events/events.dart';
import 'package:provider/provider.dart';

/// Unified drag handler widget.
///
/// Sits as the topmost surface of the day column.  A single [Listener]
/// intercepts all pointer events and, after the hold threshold, decides
/// whether the gesture should create a new event, move an existing one, or
/// resize one — based on where the pointer landed relative to the saved
/// events.  All drag state is managed by [DragHandlerBloc]; this widget only
/// translates raw pointer events into bloc events.
class UnifiedDragHandler extends StatefulWidget {
  const UnifiedDragHandler({required this.child, super.key});

  final Widget child;

  @override
  State<UnifiedDragHandler> createState() => _UnifiedDragHandlerState();
}

class _UnifiedDragHandlerState extends State<UnifiedDragHandler> {
  /// Pointer must be held this long without moving to start a drag gesture.
  static const _holdDuration = Duration(milliseconds: 300);

  /// Movement beyond this threshold during the hold cancels it (user is
  /// scrolling).
  static const _cancelMovementThreshold = 8.0;

  /// Height of the resize zone at the bottom edge of an event box.
  static const _resizeBorderHeight = 12.0;

  Timer? _holdTimer;
  Offset? _pointerDownPosition;
  bool _isDragging = false;

  // ── helpers ─────────────────────────────────────────────────────────────

  DateTime _localYToDateTime(double localY) {
    final dayData = context.read<DayData>();
    final scrollController = context.read<ScrollController>();
    final scrollOffset =
        scrollController.hasClients ? scrollController.offset : 0.0;
    final totalOffset = scrollOffset + localY;
    final totalMinutes =
        (totalOffset / CalendarSettings.hourUnitHeight * 60).floor();
    final hours = (totalMinutes ~/ 60).clamp(0, 23);
    final minutes = (totalMinutes % 60).clamp(0, 59);
    final day = dayData.hours.first;
    return DateTime(day.year, day.month, day.day, hours, minutes);
  }

  double _dateTimeToCalendarY(DateTime dt) =>
      (dt.hour + dt.minute / 60.0) * CalendarSettings.hourUnitHeight;

  /// Returns the hit event (and whether the pointer is in the resize zone) if
  /// [localY] falls within any event box.  Returns null for empty space.
  ({
    String eventId,
    DateTime eventStart,
    DateTime eventEnd,
    bool isResize,
  })? _hitTestEvents(double localY) {
    final dayData = context.read<DayData>();
    final scrollController = context.read<ScrollController>();
    final scrollOffset =
        scrollController.hasClients ? scrollController.offset : 0.0;
    final calendarY = scrollOffset + localY;

    final day = dayData.hours.first;
    final dayEvents = context
        .read<EventsBloc>()
        .state
        .events
        .where(
          (e) =>
              e.startDate.year == day.year &&
              e.startDate.month == day.month &&
              e.startDate.day == day.day,
        )
        .toList();

    // Iterate in reverse so topmost-rendered event wins.
    for (final event in dayEvents.reversed) {
      final startY = _dateTimeToCalendarY(event.startDate);
      final endY = _dateTimeToCalendarY(event.endDate);
      if (calendarY >= startY && calendarY <= endY) {
        final isResize = (endY - calendarY) <= _resizeBorderHeight;
        return (
          eventId: event.id,
          eventStart: event.startDate,
          eventEnd: event.endDate,
          isResize: isResize,
        );
      }
    }
    return null;
  }

  void _cancelHold() {
    _holdTimer?.cancel();
    _holdTimer = null;
    _pointerDownPosition = null;
  }

  // ── pointer callbacks ────────────────────────────────────────────────────

  void _onPointerDown(PointerDownEvent event) {
    _pointerDownPosition = event.localPosition;
    _holdTimer = Timer(_holdDuration, () {
      final hit = _hitTestEvents(event.localPosition.dy);
      final time = _localYToDateTime(event.localPosition.dy);

      final DragHandlerGestureStarted started;
      if (hit != null) {
        started = DragHandlerGestureStarted(
          mode: hit.isResize ? DragMode.resizingEvent : DragMode.movingEvent,
          time: time,
          eventId: hit.eventId,
          eventStart: hit.eventStart,
          eventEnd: hit.eventEnd,
        );
      } else {
        started = DragHandlerGestureStarted(
          mode: DragMode.creatingEvent,
          time: time,
        );
      }

      context.read<DragHandlerBloc>().add(started);
      setState(() => _isDragging = true);
    });
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_isDragging) {
      context.read<DragHandlerBloc>().add(
        DragHandlerDragUpdated(
          time: _localYToDateTime(event.localPosition.dy),
        ),
      );
    } else {
      final down = _pointerDownPosition;
      if (down != null) {
        final distance = (event.localPosition - down).distance;
        if (distance > _cancelMovementThreshold) _cancelHold();
      }
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    _cancelHold();
    if (_isDragging) {
      context.read<DragHandlerBloc>().add(const DragHandlerDragEnded());
      setState(() => _isDragging = false);
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _cancelHold();
    if (_isDragging) {
      context.read<DragHandlerBloc>().add(const DragHandlerDragEnded());
      setState(() => _isDragging = false);
    }
  }

  // ── build ────────────────────────────────────────────────────────────────

  @override
  void dispose() {
    _holdTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      // translucent: the Listener fires but doesn't claim the pointer — the
      // ListView beneath can still scroll freely when not dragging.
      behavior: HitTestBehavior.translucent,
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      // AbsorbPointer prevents the ListView and EventBoxes from receiving
      // events only while a drag is active.
      child: AbsorbPointer(
        absorbing: _isDragging,
        child: widget.child,
      ),
    );
  }
}
