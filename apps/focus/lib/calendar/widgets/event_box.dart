import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    final displayStart = overrideStart ?? event.startDate;
    final displayEnd = overrideEnd ?? event.endDate;
    final startFraction = displayStart.hour + displayStart.minute / 60.0;
    final endFraction = displayEnd.hour + displayEnd.minute / 60.0;
    final top = startFraction * CalendarSettings.hourUnitHeight - scrollOffset;
    final height =
        (endFraction - startFraction) * CalendarSettings.hourUnitHeight;

    final textTheme = Theme.of(context).textTheme;

    return Positioned(
      top: top,
      left: 4,
      right: 4,
      height: height.clamp(20.0, double.infinity),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap:
            () => context.read<EventPreviewBloc>().add(
              EventEditStarted(
                eventId: event.id,
                startTime: event.startDate,
                endTime: event.endDate,
                name: event.name,
              ),
            ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(56, 8, 255, 247),
                Color.fromARGB(26, 5, 193, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(47, 0, 0, 0),
                blurRadius: 30,
                spreadRadius: 10,
                offset: Offset.zero,
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                event.name,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color.fromARGB(255, 200, 255, 238),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                _fmtDuration(displayStart, displayEnd),
                style: textTheme.labelSmall?.copyWith(
                  color: const Color.fromARGB(255, 0, 176, 251),
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _fmt(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _fmtDuration(DateTime start, DateTime end) {
    final totalMinutes = end.difference(start).inMinutes;
    final hours = totalMinutes ~/ 60;
    final minutes = (totalMinutes % 60).toString().padLeft(2, '0');
    final durationStr =
        hours > 0
            ? (minutes != '00' ? '${hours}h ${minutes}min' : '${hours}h')
            : '$minutes min';
    return '$durationStr (${_fmt(start)} - ${_fmt(end)})';
  }
}
