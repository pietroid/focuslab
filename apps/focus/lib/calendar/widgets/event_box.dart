import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/calendar/bloc/drag_event_bloc.dart';
import 'package:focus/calendar/bloc/event_preview_bloc.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';
import 'package:focus/events/models/event_model.dart';

class EventBox extends StatelessWidget {
  const EventBox({
    required this.event,
    required this.scrollOffset,
    this.overrideStart,
    this.overrideEnd,
    super.key,
  });

  final Event event;
  final double scrollOffset;

  /// When non-null, renders at this position instead of the stored event times.
  final DateTime? overrideStart;
  final DateTime? overrideEnd;

  /// Converts a localPosition (relative to this Positioned widget) to a
  /// DateTime in the day's coordinate space, accounting for scroll.
  DateTime _localToDateTime(Offset localPosition) {
    final startFraction =
        event.startDate.hour + event.startDate.minute / 60.0;
    final calendarY =
        startFraction * CalendarSettings.hourUnitHeight + localPosition.dy;
    final totalMinutes =
        (calendarY / CalendarSettings.hourUnitHeight * 60).floor();
    final hours = (totalMinutes ~/ 60).clamp(0, 23);
    final minutes = (totalMinutes % 60).clamp(0, 59);
    final day = event.startDate;
    return DateTime(day.year, day.month, day.day, hours, minutes);
  }

  @override
  Widget build(BuildContext context) {
    final displayStart = overrideStart ?? event.startDate;
    final displayEnd = overrideEnd ?? event.endDate;
    final startFraction = displayStart.hour + displayStart.minute / 60.0;
    final endFraction = displayEnd.hour + displayEnd.minute / 60.0;
    final top = startFraction * CalendarSettings.hourUnitHeight - scrollOffset;
    final height =
        (endFraction - startFraction) * CalendarSettings.hourUnitHeight;

    return Positioned(
      top: top,
      left: 4,
      right: 4,
      height: height.clamp(20.0, double.infinity),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.read<EventPreviewBloc>().add(
          EventEditStarted(
            eventId: event.id,
            startTime: event.startDate,
            endTime: event.endDate,
            name: event.name,
          ),
        ),
        onPanStart: (details) => context.read<DragEventBloc>().add(
          EventDragStarted(
            eventId: event.id,
            eventStart: event.startDate,
            eventEnd: event.endDate,
            pointerTime: _localToDateTime(details.localPosition),
          ),
        ),
        onPanUpdate: (details) => context.read<DragEventBloc>().add(
          EventDragUpdated(
            pointerTime: _localToDateTime(details.localPosition),
          ),
        ),
        onPanEnd: (_) =>
            context.read<DragEventBloc>().add(const EventDragEnded()),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x9950E8FF),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(4),
          child: Text(
            event.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
