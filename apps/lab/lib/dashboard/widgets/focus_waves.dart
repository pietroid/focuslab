import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/dashboard/bloc/time_bloc.dart';

/// Radius of the inner clock
const coreRadius = 100;

/// Number of waves to display
const numberOfWaves = 300;

/// Time increment in minutes for each wave (e.g., 10 means a wave every 10 minutes).
const Duration timeIncrement = Duration(minutes: 1);

double r(
  int t,
  int inflectionPoint,
  double alpha,
) {
  /// velocity at 0, px per ms
  final v0 = alpha / (inflectionPoint - alpha);
  return alpha * log((v0 * t) / alpha + 1);
}

class FocusWaves extends StatelessWidget {
  const FocusWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeBloc, TimeState>(builder: (context, state) {
      final now = state.now;

      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: generateWaves(now),
        ),
      );
    });
  }
}

List<CenterCircleCanvas> generateWaves(
  DateTime now,
) {
  /// Base in minutes of the logarythimic equation.
  final base = 60 * 1000 * 0.01;

  /// Alpha constant used in the equation, this is the definition.
  final alpha = 1 / log(base);

  /// Inflection point of 1 minute.
  final inflectionPoint = (60 * 1000 * 0.02).toInt();

  final waves = <CenterCircleCanvas>[];

  final timePoints = calculateNextTimeIncrementsGrid(now, numberOfWaves);

  for (int i = 0; i < numberOfWaves; i++) {
    /// Calculate the next time increment based on the current time and the time increment
    final nextTimeDifference = timePoints[i].difference(now).inMilliseconds;

    final distanceFromCore =
        r(nextTimeDifference, inflectionPoint, alpha) * 400;

    final radius = coreRadius + distanceFromCore;

    final showLabel = i % 5 == 0; // Show label for every 5th wave

    /// Create a new wave with the calculated radius and label
    final circle = CenterCircleCanvas(
      label: showLabel
          ? '${timePoints[i].hour.toString().padLeft(2, '0')}:${timePoints[i].minute.toString().padLeft(2, '0')}'
          : null,
      diameter: radius * 2,
      color: showLabel
          ? Color.fromARGB(255, 251, 255, 255)
              .withOpacity(pow(1 - (i / numberOfWaves), 2).toDouble())
          : Color.fromARGB(255, 30, 89, 95)
              .withOpacity(pow(1 - (i / numberOfWaves), 2).toDouble()),
    );

    waves.add(circle);
  }

  return waves;
}

List<DateTime> calculateNextTimeIncrementsGrid(
    DateTime now, int numberOfPoints) {
  final points = <DateTime>[];

  /// get the current time at midnight
  final nowMidnight = DateTime(now.year, now.month, now.day);

  DateTime firstPoint = nowMidnight;

  /// gets the next closest time according to the currentTime
  while (firstPoint.isBefore(now)) {
    firstPoint = firstPoint.add(timeIncrement);
  }

  /// add the first point to the list
  points.add(firstPoint);

  /// add the next points to the list
  for (int i = 1; i < numberOfPoints; i++) {
    firstPoint = firstPoint.add(timeIncrement);
    points.add(firstPoint);
  }

  return points;
}

class CenterCircleCanvas extends StatelessWidget {
  final double diameter;
  final Color color;
  final String? label;

  const CenterCircleCanvas({
    Key? key,
    this.diameter = 100,
    required this.color,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(diameter, diameter),
          painter: _CenterCirclePainter(diameter: diameter, color: color),
        ),
        if (label != null)
          Transform.translate(
            offset: Offset(diameter / 2 - 30, 0),
            child: Text(
              label!,
              style: TextStyle(fontSize: 15, color: color),
            ),
          ),
      ],
    );
  }
}

class _CenterCirclePainter extends CustomPainter {
  final double diameter;
  final Color color;

  _CenterCirclePainter({required this.diameter, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, diameter / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
