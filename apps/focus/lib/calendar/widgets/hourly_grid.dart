import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/calendar/bloc/calendar_bloc.dart';
import 'package:focus/calendar/bloc/drag_event_bloc.dart';
import 'package:focus/calendar/bloc/drag_grid_bloc.dart';
import 'package:focus/calendar/bloc/event_preview_bloc.dart';
import 'package:focus/calendar/calendar.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';
import 'package:focus/calendar/widgets/drag_handler.dart';
import 'package:focus/calendar/widgets/event_box.dart';
import 'package:focus/calendar/widgets/event_preview_box.dart';
import 'package:focus/calendar/widgets/hour_unit.dart';
import 'package:focus/events/events.dart';

class HourlyGrid extends StatelessWidget {
  const HourlyGrid({super.key});

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Widget _buildDragPreview(DragGridState dragState, double scrollOffset) {
    final start = dragState.startTime!;
    final current = dragState.currentTime!;
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

    return MultiBlocListener(
      listeners: [
        BlocListener<DragGridBloc, DragGridState>(
          listenWhen: (_, curr) => curr.hasCompleted,
          listener: (context, state) {
            context.read<EventPreviewBloc>().add(
              PreviewStarted(
                startTime: state.completedStart!,
                endTime: state.completedEnd!,
              ),
            );
            context.read<DragGridBloc>().add(const DragResultConsumed());
          },
        ),
        BlocListener<DragEventBloc, DragEventState>(
          listenWhen: (_, curr) => curr.hasCompleted,
          listener: (context, state) {
            final original = context
                .read<EventsBloc>()
                .state
                .events
                .firstWhere((e) => e.id == state.completedEventId);
            context.read<EventsBloc>().add(
              EventUpdated(
                event: original.copyWith(
                  startDate: state.completedStart,
                  endDate: state.completedEnd,
                ),
              ),
            );
            context.read<DragEventBloc>().add(const EventDragResultConsumed());
          },
        ),
        BlocListener<EventPreviewBloc, EventPreviewState>(
          listenWhen: (_, curr) => curr.isConfirmed,
          listener: (context, state) {
            final name = state.name.isEmpty ? 'New Event' : state.name;
            if (state.eventId != null) {
              context.read<EventsBloc>().add(
                EventUpdated(
                  event: Event(
                    id: state.eventId!,
                    name: name,
                    startDate: state.startTime!,
                    endDate: state.endTime!,
                  ),
                ),
              );
            } else {
              context.read<EventsBloc>().add(
                EventAdded(
                  event: Event(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    startDate: state.startTime!,
                    endDate: state.endTime!,
                  ),
                ),
              );
            }
            context.read<EventPreviewBloc>().add(const PreviewResultConsumed());
          },
        ),
      ],
      child: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, calendarState) {
          final now = calendarState.now;
          final isToday = _isSameDay(now, dayData.hours.first);

          return BlocBuilder<EventsBloc, EventsState>(
            builder: (context, eventsState) {
              final dayEvents = eventsState.events
                  .where((e) => _isSameDay(e.startDate, dayData.hours.first))
                  .toList();

              return BlocBuilder<DragGridBloc, DragGridState>(
                builder: (context, dragGridState) {
                  return BlocBuilder<DragEventBloc, DragEventState>(
                    builder: (context, dragEventState) {
                      final dragGridBloc = context.read<DragGridBloc>();
                      final isScrollLocked =
                          dragGridState.isDragging ||
                          dragEventState.isDragging;

                      return CalendarDragHandler(
                        canCreate: () => !dragEventState.isDragging,
                        onStartDragTime: (t) =>
                            dragGridBloc.add(DragStarted(time: t)),
                        onEndDragTime: (t) =>
                            dragGridBloc.add(DragEnded(time: t)),
                        onDragUpdate: (t) =>
                            dragGridBloc.add(DragUpdated(time: t)),
                        child: Stack(
                          children: [
                            ListView.builder(
                              controller: scrollController,
                              physics: isScrollLocked
                                  ? const NeverScrollableScrollPhysics()
                                  : const _SnapScrollPhysics(
                                      itemExtent:
                                          CalendarSettings.hourUnitHeight,
                                    ),
                              itemExtent: CalendarSettings.hourUnitHeight,
                              itemCount: dayData.hours.length,
                              itemBuilder: (context, index) {
                                final hour = dayData.hours[index];
                                final nowFraction =
                                    isToday && hour.hour == now.hour
                                        ? (now.minute * 60 + now.second) /
                                            3600.0
                                        : null;
                                return HourUnit(
                                  startTime: hour,
                                  nowFraction: nowFraction,
                                );
                              },
                            ),
                            Positioned.fill(
                              child: Stack(
                                children: [
                                  // Non-interactive: new-event drag ghost only
                                  if (dragGridState.startTime != null &&
                                      dragGridState.currentTime != null)
                                    IgnorePointer(
                                      child: AnimatedBuilder(
                                        animation: scrollController,
                                        builder: (context, _) {
                                          final scrollOffset =
                                              scrollController.hasClients
                                                  ? scrollController.offset
                                                  : 0.0;
                                          return Stack(
                                            children: [
                                              _buildDragPreview(
                                                dragGridState,
                                                scrollOffset,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  // Interactive: saved event boxes.
                                  // Positioned.fill gives the inner Stack
                                  // proper bounds so EventBox hit-testing
                                  // works and touches don't fall through
                                  // to the ListView.
                                  Positioned.fill(
                                    child: AnimatedBuilder(
                                      animation: scrollController,
                                      builder: (context, _) {
                                        final scrollOffset =
                                            scrollController.hasClients
                                                ? scrollController.offset
                                                : 0.0;
                                        return Stack(
                                          children: [
                                            for (final event in dayEvents)
                                              EventBox(
                                                key: ValueKey(event.id),
                                                event: event,
                                                scrollOffset: scrollOffset,
                                                overrideStart: dragEventState
                                                            .draggingEventId ==
                                                        event.id
                                                    ? dragEventState
                                                        .currentStart
                                                    : null,
                                                overrideEnd: dragEventState
                                                            .draggingEventId ==
                                                        event.id
                                                    ? dragEventState.currentEnd
                                                    : null,
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  // Interactive: name text field after drag
                                  Positioned.fill(
                                    child: BlocBuilder<EventPreviewBloc,
                                        EventPreviewState>(
                                      builder: (context, previewState) {
                                        if (!previewState.isActive) {
                                          return const SizedBox.shrink();
                                        }
                                        return AnimatedBuilder(
                                          animation: scrollController,
                                          builder: (context, _) {
                                            final scrollOffset =
                                                scrollController.hasClients
                                                    ? scrollController.offset
                                                    : 0.0;
                                            return Stack(
                                              children: [
                                                EventPreviewBox(
                                                  startTime:
                                                      previewState.startTime!,
                                                  endTime:
                                                      previewState.endTime!,
                                                  scrollOffset: scrollOffset,
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
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
