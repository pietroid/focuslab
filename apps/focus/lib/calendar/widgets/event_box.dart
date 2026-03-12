import 'package:app_ui/app_ui.dart';
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
      left: 0,
      right: 0,
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
            color: const Color.fromARGB(81, 0, 77, 108),
            border: BoxBorder.all(
              color: const Color.fromARGB(51, 255, 255, 255),
            ),
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(79, 0, 0, 0),
                blurRadius: 20,
                spreadRadius: 20,
                offset: Offset.zero,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w100,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  _fmtDuration(displayStart, displayEnd),
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color.fromARGB(150, 255, 255, 255),
                    fontSize: 11,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
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
    final hours = (totalMinutes ~/ 60).toString().padLeft(2, '0');
    final minutes = (totalMinutes % 60).toString().padLeft(2, '0');
    final durationStr =
        hours != '00'
            ? (minutes != '00' ? '${hours}:${minutes}' : '${hours}h')
            : '$minutes min';
    return '$durationStr';
  }
}
