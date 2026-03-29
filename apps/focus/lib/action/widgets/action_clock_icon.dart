import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:focus/action/bloc/action_bloc.dart';

/// {@template action_clock_icon}
/// A custom-painted clock whose minute hand angle is derived from the
/// selected [ActionDuration].
///
/// The face is drawn as a thin circle. The minute hand rotates to reflect the
/// duration value (e.g. 30 min → 6 o'clock), while a short decorative hour
/// hand always points toward 10 o'clock.
/// {@endtemplate}
class ActionClockIcon extends StatelessWidget {
  /// {@macro action_clock_icon}
  const ActionClockIcon({required this.duration, super.key});

  /// Drives the minute-hand position.
  final ActionDuration duration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(
        painter: _ClockPainter(minuteFraction: duration.minutes / 60.0),
      ),
    );
  }
}

/// {@template _clock_painter}
/// Renders a minimalist clock face for use inside [ActionClockIcon].
/// {@endtemplate}
class _ClockPainter extends CustomPainter {
  const _ClockPainter({required this.minuteFraction});

  /// Fraction of the clock face: `0.0` = 12 o'clock, `0.5` = 6 o'clock.
  final double minuteFraction;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 1;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color.fromARGB(180, 255, 255, 255)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );

    final minuteAngle = -math.pi / 2 + minuteFraction * 2 * math.pi;
    canvas.drawLine(
      center,
      Offset(
        center.dx + radius * 0.65 * math.cos(minuteAngle),
        center.dy + radius * 0.65 * math.sin(minuteAngle),
      ),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round,
    );

    const hourAngle = -math.pi / 2 - math.pi / 3;
    canvas.drawLine(
      center,
      Offset(
        center.dx + radius * 0.4 * math.cos(hourAngle),
        center.dy + radius * 0.4 * math.sin(hourAngle),
      ),
      Paint()
        ..color = const Color.fromARGB(150, 255, 255, 255)
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_ClockPainter old) => old.minuteFraction != minuteFraction;
}
