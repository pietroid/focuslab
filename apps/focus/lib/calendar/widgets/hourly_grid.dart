import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/calendar/bloc/calendar_bloc.dart';
import 'package:focus/calendar/bloc/drag_handler_bloc.dart';
import 'package:focus/calendar/bloc/event_preview_bloc.dart';
import 'package:focus/calendar/calendar_view.dart';
import 'package:focus/calendar/models/day_data.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';
import 'package:focus/calendar/widgets/current_time_bar.dart';
import 'package:focus/calendar/widgets/drag_handler.dart';
import 'package:focus/calendar/widgets/event_box.dart';
import 'package:focus/calendar/widgets/event_preview_box.dart';
import 'package:focus/calendar/widgets/hour_unit.dart';
import 'package:focus/events/events.dart';

class HourlyGrid extends StatelessWidget {
  const HourlyGrid({super.key});

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Widget _buildCreatePreview(DragHandlerState state, double scrollOffset) {
    final anchor = state.startTime!;
    final cursor = state.currentTime!;
    final actualStart = anchor.isBefore(cursor) ? anchor : cursor;
    final actualEnd = anchor.isBefore(cursor) ? cursor : anchor;
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
        BlocListener<DragHandlerBloc, DragHandlerState>(
          listenWhen: (_, curr) => curr.hasCompleted,
          listener: (context, state) {
            switch (state.completedMode!) {
              case DragMode.creatingEvent:
                context.read<EventPreviewBloc>().add(
                  PreviewStarted(
                    startTime: state.completedStart!,
                    endTime: state.completedEnd!,
                  ),
                );
              case DragMode.movingEvent:
              case DragMode.resizingEvent:
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
            }
            context.read<DragHandlerBloc>().add(
              const DragHandlerResultConsumed(),
            );
          },
        ),
        BlocListener<EventPreviewBloc, EventPreviewState>(
          listenWhen: (_, curr) => curr.isConfirmed,
          listener: (context, state) {
            if (state.name.isEmpty) {
              if (state.eventId != null) {
                context.read<EventsBloc>().add(
                  EventDeleted(eventId: state.eventId!),
                );
              }
            } else if (state.eventId != null) {
              context.read<EventsBloc>().add(
                EventUpdated(
                  event: Event(
                    id: state.eventId!,
                    name: state.name,
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
                    name: state.name,
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
              final dayEvents =
                  eventsState.events
                      .where(
                        (e) => _isSameDay(e.startDate, dayData.hours.first),
                      )
                      .toList();

              return BlocBuilder<DragHandlerBloc, DragHandlerState>(
                builder: (context, dragHandlerState) {
                  return Padding(
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 4),
                    child: UnifiedDragHandler(
                      child: Stack(
                        children: [
                          // ── Layer 1: scrollable hour grid ────────────────
                          ListView.builder(
                            controller: scrollController,
                            physics:
                                dragHandlerState.isDragging
                                    ? const NeverScrollableScrollPhysics()
                                    : const _SnapScrollPhysics(
                                      itemExtent:
                                          CalendarSettings.hourUnitHeight,
                                    ),
                            itemExtent: CalendarSettings.hourUnitHeight,
                            itemCount: dayData.hours.length,
                            itemBuilder: (context, index) {
                              return HourUnit(startTime: dayData.hours[index]);
                            },
                          ),

                          // ── Layer 2: event boxes ─────────────────────────
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
                                        overrideStart:
                                            dragHandlerState.eventId == event.id
                                                ? (dragHandlerState.mode ==
                                                        DragMode.movingEvent
                                                    ? dragHandlerState
                                                        .currentStart
                                                    : dragHandlerState
                                                        .startTime)
                                                : null,
                                        overrideEnd:
                                            dragHandlerState.eventId == event.id
                                                ? dragHandlerState.currentEnd
                                                : null,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),

                          // ── Layer 3: current time bar (day-level) ────────
                          if (isToday)
                            Positioned.fill(
                              child: IgnorePointer(
                                child: AnimatedBuilder(
                                  animation: scrollController,
                                  builder: (context, _) {
                                    final scrollOffset =
                                        scrollController.hasClients
                                            ? scrollController.offset
                                            : 0.0;
                                    final nowY =
                                        (now.hour +
                                                now.minute / 60.0 +
                                                now.second / 3600.0) *
                                            CalendarSettings.hourUnitHeight -
                                        scrollOffset;
                                    return Stack(
                                      children: [
                                        Positioned(
                                          top: nowY,
                                          left: 0,
                                          right: 0,
                                          child: const CurrentTimeBar(),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),

                          // ── Layer 4: new-event drag ghost ────────────────
                          if (dragHandlerState.mode == DragMode.creatingEvent &&
                              dragHandlerState.startTime != null &&
                              dragHandlerState.currentTime != null)
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
                                      _buildCreatePreview(
                                        dragHandlerState,
                                        scrollOffset,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                          // ── Layer 5: event name text field ───────────────
                          Positioned.fill(
                            child: BlocBuilder<
                              EventPreviewBloc,
                              EventPreviewState
                            >(
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
                                          startTime: previewState.startTime!,
                                          endTime: previewState.endTime!,
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
