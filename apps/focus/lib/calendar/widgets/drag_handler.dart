import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focus/calendar/calendar.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';
import 'package:provider/provider.dart';

class CalendarDragHandler extends StatefulWidget {
  const CalendarDragHandler({
    required this.child,
    required this.onStartDragTime,
    required this.onEndDragTime,
    this.onDragUpdate,
    super.key,
  });

  final Widget child;

  /// Called once when the hold threshold is reached and event creation begins.
  final void Function(DateTime) onStartDragTime;

  /// Called when the pointer is released — triggers event creation.
  final void Function(DateTime) onEndDragTime;

  /// Called on every pointer move while in event creation mode.
  final void Function(DateTime)? onDragUpdate;

  @override
  State<CalendarDragHandler> createState() => _CalendarDragHandlerState();
}

class _CalendarDragHandlerState extends State<CalendarDragHandler> {
  // Pointer must be held this long without moving to start event creation.
  static const _holdDuration = Duration(milliseconds: 300);

  // Movement beyond this many pixels during the hold cancels event creation.
  static const _cancelMovementThreshold = 8.0;

  Timer? _holdTimer;
  Offset? _pointerDownPosition;
  bool _isCreatingEvent = false;

  DateTime _positionToDateTime(double localY) {
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

  void _cancelHold() {
    _holdTimer?.cancel();
    _holdTimer = null;
    _pointerDownPosition = null;
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      // translucent: the Listener fires but doesn't claim the hit — the
      // ListView beneath can still win the gesture arena and scroll freely.
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        _pointerDownPosition = event.localPosition;
        _holdTimer = Timer(_holdDuration, () {
          // Hold threshold reached — switch to event creation mode.
          // AbsorbPointer will now block the ListView from receiving events.
          setState(() => _isCreatingEvent = true);
          widget.onStartDragTime(_positionToDateTime(event.localPosition.dy));
        });
      },
      onPointerMove: (event) {
        if (_isCreatingEvent) {
          widget.onDragUpdate
              ?.call(_positionToDateTime(event.localPosition.dy));
        } else {
          // Cancel hold if the pointer moves too far (user is scrolling).
          final down = _pointerDownPosition;
          if (down != null) {
            final distance = (event.localPosition - down).distance;
            if (distance > _cancelMovementThreshold) {
              _cancelHold();
            }
          }
        }
      },
      onPointerUp: (event) {
        _cancelHold();
        if (_isCreatingEvent) {
          widget.onEndDragTime(_positionToDateTime(event.localPosition.dy));
          setState(() => _isCreatingEvent = false);
        }
      },
      onPointerCancel: (_) {
        _cancelHold();
        if (_isCreatingEvent) {
          setState(() => _isCreatingEvent = false);
        }
      },
      // AbsorbPointer prevents the ListView from receiving pointer events
      // only while event creation is active, leaving normal scroll unaffected.
      child: AbsorbPointer(
        absorbing: _isCreatingEvent,
        child: widget.child,
      ),
    );
  }
}
