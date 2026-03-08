import 'package:flutter/material.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';
import 'package:focus/calendar/widgets/current_time_bar.dart';

class HourUnit extends StatelessWidget {
  const HourUnit({required this.startTime, this.nowFraction, super.key});

  final DateTime startTime;

  /// If non-null, renders a "now" indicator bar at this fraction (0.0–1.0)
  /// of the unit's height.
  final double? nowFraction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Container(
        height: CalendarSettings.hourUnitHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          // gradient: const LinearGradient(
          //   colors: [
          //     Color.fromARGB(4, 255, 255, 255),
          //     Color.fromARGB(0, 255, 255, 255),
          //   ],
          //   stops: [0.0, 0.5],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          border: Border.all(
            color: const Color.fromARGB(255, 172, 172, 172),
            width: 0.05,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Transform.translate(
                  offset: const Offset(0, 0),
                  child: Text(
                    startTime.toTimeString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color.fromARGB(147, 255, 255, 255),
                      fontSize: 11,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ),
            ),
            if (nowFraction != null)
              Transform.translate(
                offset: Offset(
                  0,
                  nowFraction! * CalendarSettings.hourUnitHeight,
                ),

                child: const CurrentTimeBar(),
              ),
          ],
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
