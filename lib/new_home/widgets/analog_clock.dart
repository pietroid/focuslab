import 'dart:math';
import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/new_home/widgets/fragment_provider.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock({super.key, this.showSecondsHand = true});
  final bool showSecondsHand;

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _now = DateTime.now();
      });
    })
      ..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(
        painter: _ClockPainter(
          now: _now,
          showSecondsHand: widget.showSecondsHand,
          shader: context
              .read<AnalogClockFragmentProvider>()
              .fragmentProgram
              .fragmentShader(),
        ),
      ),
    );
  }
}

class _ClockPainter extends CustomPainter {
  _ClockPainter({
    required this.now,
    required this.showSecondsHand,
    required this.shader,
  });

  final DateTime now;
  final bool showSecondsHand;
  final FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    final Color midDayColor = const Color.fromARGB(255, 255, 243, 163);
    final Color dayColor = const Color.fromARGB(255, 255, 177, 8);
    final Color midNightColor = const Color.fromARGB(255, 0, 0, 0);
    final Color nightColor = const Color.fromARGB(255, 0, 35, 100);

    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;

    final facePaint = Paint()..shader = shader;

    Rect rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.shortestSide / 2,
    );

    // Compute hand angles
    final secondValue = now.second + now.millisecond / 1000.0;
    final minuteValue = now.minute + secondValue / 60.0;
    final hourValue = (now.hour % 12) + minuteValue / 60.0;

    final hourAngle = (hourValue / 24.0) * 2 * pi - pi / 2;
    final secondAngle = (secondValue / 60.0) * 2 * pi;

    //canvas.drawArc(rect, secondAngle, -pi / 2, false, paint);

    // MidDay Color
    shader.setFloat(2, midDayColor.r);
    shader.setFloat(3, midDayColor.g);
    shader.setFloat(4, midDayColor.b);
    shader.setFloat(5, midDayColor.a);

    // Day Color
    shader.setFloat(6, dayColor.r);
    shader.setFloat(7, dayColor.g);
    shader.setFloat(8, dayColor.b);
    shader.setFloat(9, dayColor.a);

    // // // MidNight Color
    shader.setFloat(10, midNightColor.r);
    shader.setFloat(11, midNightColor.g);
    shader.setFloat(12, midNightColor.b);
    shader.setFloat(13, midNightColor.a);

    // // Night Color
    shader.setFloat(14, nightColor.r);
    shader.setFloat(15, nightColor.g);
    shader.setFloat(16, nightColor.b);
    shader.setFloat(17, nightColor.a);

    shader.setFloat(18, 5.0); // dayColorTimeDelta
    shader.setFloat(19, 8.0); // nightColorTimeDelta

    // Face (outer ring)
    canvas.drawCircle(center, radius, facePaint);
  }

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) =>
      oldDelegate.now != now || oldDelegate.showSecondsHand != showSecondsHand;

  static Offset _offsetFromAngle(double angle) =>
      Offset(sin(angle), -cos(angle)); // 12 o'clock at top
}
