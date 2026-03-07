import 'package:flutter/material.dart';

class HourUnit extends StatelessWidget {
  const HourUnit({required this.startTime, super.key});

  final DateTime startTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(40, 255, 255, 255),
          width: 0.5,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 8,
            top: 8,
            child: Text(
              startTime.toTimeString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color.fromARGB(150, 255, 255, 255),
                fontSize: 10,
              ),
            ),
          ),
        ],
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
