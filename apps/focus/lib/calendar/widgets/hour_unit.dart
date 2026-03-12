import 'package:flutter/material.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';

class HourUnit extends StatelessWidget {
  const HourUnit({required this.startTime, super.key});

  final DateTime startTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CalendarSettings.hourUnitHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 172, 172, 172),
          width: 0.05,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(left: 6, top: 4, right: 6),
          child: Text(
            startTime.toTimeString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color.fromARGB(147, 255, 255, 255),
              fontSize: 10,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ),
    );
  }
}

extension TimeRender on DateTime {
  String toTimeString() {
    final hour = this.hour.toString().padLeft(2, '0');
    return '$hour:00';
  }
}
