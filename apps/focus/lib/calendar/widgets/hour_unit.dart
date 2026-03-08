import 'package:flutter/material.dart';
import 'package:focus/calendar/utils/calendar_settings.dart';

class HourUnit extends StatelessWidget {
  const HourUnit({required this.startTime, super.key});

  final DateTime startTime;

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
