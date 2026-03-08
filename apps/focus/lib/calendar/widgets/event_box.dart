import 'package:flutter/material.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';
import 'package:focus/events/models/event_model.dart';

class EventBox extends StatelessWidget {
  const EventBox({required this.event, required this.scrollOffset, super.key});

  final Event event;
  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final startFraction =
        event.startDate.hour + event.startDate.minute / 60.0;
    final endFraction = event.endDate.hour + event.endDate.minute / 60.0;
    final top =
        startFraction * CalendarSettings.hourUnitHeight - scrollOffset;
    final height =
        (endFraction - startFraction) * CalendarSettings.hourUnitHeight;

    return Positioned(
      top: top,
      left: 4,
      right: 4,
      height: height.clamp(20.0, double.infinity),
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
    );
  }
}
