import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/calendar/bloc/calendar_bloc.dart';
import 'package:focus/calendar/calendar.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';
import 'package:focus/calendar/widgets/drag_handler.dart';
import 'package:focus/calendar/widgets/event_box.dart';
import 'package:focus/calendar/widgets/hour_unit.dart';
import 'package:focus/events/events.dart';

class HourlyGrid extends StatefulWidget {
  const HourlyGrid({super.key});

  @override
  State<HourlyGrid> createState() => _HourlyGridState();
}

class _HourlyGridState extends State<HourlyGrid> {
  DateTime? _dragStartTime;
  DateTime? _dragCurrentTime;

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _onStartDragTime(DateTime time) {
    setState(() {
      _dragStartTime = time;
      _dragCurrentTime = time;
    });
  }

  void _onDragUpdate(DateTime time) {
    setState(() => _dragCurrentTime = time);
  }

  void _onEndDragTime(DateTime time) {
    final start = _dragStartTime;
    if (start != null) {
      final actualStart = start.isBefore(time) ? start : time;
      final actualEnd = start.isBefore(time) ? time : start;
      if (actualStart != actualEnd) {
        context.read<EventsBloc>().add(
          EventAdded(
            event: Event(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: 'New Event',
              startDate: actualStart,
              endDate: actualEnd,
            ),
          ),
        );
      }
    }
    setState(() {
      _dragStartTime = null;
      _dragCurrentTime = null;
    });
  }

  Widget _buildDragPreview(double scrollOffset) {
    final start = _dragStartTime!;
    final current = _dragCurrentTime!;
    final actualStart = start.isBefore(current) ? start : current;
    final actualEnd = start.isBefore(current) ? current : start;
    final startFraction = actualStart.hour + actualStart.minute / 60.0;
    final endFraction = actualEnd.hour + actualEnd.minute / 60.0;
    final top = startFraction * CalendarSettings.hourUnitHeight - scrollOffset;
    final height =
        (endFraction - startFraction) * CalendarSettings.hourUnitHeight;

    return Positioned(
      top: top,
      left: 4,
      right: 4,
      height: max(4, height),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0x3350E8FF),
          border: Border.all(color: const Color(0xFF50E8FF)),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dayData = context.read<DayData>();
    final scrollController = context.read<ScrollController>();

    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, calendarState) {
        final now = calendarState.now;
        final isToday = _isSameDay(now, dayData.hours.first);

        return BlocBuilder<EventsBloc, EventsState>(
          builder: (context, eventsState) {
            final dayEvents =
                eventsState.events
                    .where((e) => _isSameDay(e.startDate, dayData.hours.first))
                    .toList();

            return CalendarDragHandler(
              onStartDragTime: _onStartDragTime,
              onEndDragTime: _onEndDragTime,
              onDragUpdate: _onDragUpdate,
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const _SnapScrollPhysics(
                      itemExtent: CalendarSettings.hourUnitHeight,
                    ),
                    itemExtent: CalendarSettings.hourUnitHeight,
                    itemCount: dayData.hours.length,
                    itemBuilder: (context, index) {
                      final hour = dayData.hours[index];
                      final nowFraction =
                          isToday && hour.hour == now.hour
                              ? (now.minute * 60 + now.second) / 3600.0
                              : null;
                      return HourUnit(
                        startTime: hour,
                        nowFraction: nowFraction,
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: scrollController,
                    builder: (context, _) {
                      final scrollOffset = scrollController.hasClients
                          ? scrollController.offset
                          : 0.0;
                      return IgnorePointer(
                        child: Stack(
                          children: [
                            for (final event in dayEvents)
                              EventBox(
                                event: event,
                                scrollOffset: scrollOffset,
                              ),
                            if (_dragStartTime != null &&
                                _dragCurrentTime != null)
                              _buildDragPreview(scrollOffset),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _SnapScrollPhysics extends ScrollPhysics {
  const _SnapScrollPhysics({required this.itemExtent, super.parent});

  final double itemExtent;

  @override
  _SnapScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      _SnapScrollPhysics(itemExtent: itemExtent, parent: buildParent(ancestor));

  double _snapOffset(double offset) =>
      (offset / itemExtent).round() * itemExtent;

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final sim = super.createBallisticSimulation(position, velocity);
    final target = _snapOffset(
      sim != null ? sim.x(double.infinity) : position.pixels,
    );
    final tol = toleranceFor(position);
    if ((target - position.pixels).abs() < tol.distance) return null;
    return ScrollSpringSimulation(
      SpringDescription.withDampingRatio(mass: 0.1, stiffness: 1000, ratio: 2),
      position.pixels,
      target,
      velocity,
      tolerance: tol,
    );
  }

  @override
  bool get allowImplicitScrolling => false;
}
