import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/dashboard/bloc/time_bloc.dart';

const coreRadius = 200;
const numberOfWaves = 6;
const spacingBetweenWaves = 300.0;

class FocusWaves extends StatelessWidget {
  const FocusWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeBloc, TimeState>(builder: (context, state) {
      final now = state.now;

      final nextMinute = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute + 1,
      );

      final millisecondsUntilNextMinute =
          nextMinute.difference(now).inMilliseconds;

      final distanceInPixelsToNextWave =
          (millisecondsUntilNextMinute / 60000) * spacingBetweenWaves;

      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            for (int i = 0; i < numberOfWaves; i++)
              CenterCircleCanvas(
                label:
                    '${getNextMinuteIncrement(now, i + 1).hour.toString().padLeft(2, '0')}:${getNextMinuteIncrement(now, i + 1).minute.toString().padLeft(2, '0')}',
                diameter: coreRadius +
                    (i * spacingBetweenWaves) +
                    distanceInPixelsToNextWave,
                color: Color.fromARGB(255, 255, 255, 255)
                    .withOpacity(pow(1 - (i / numberOfWaves), 2).toDouble()),
              ),
          ],
        ),
      );
    });
  }
}

DateTime getNextMinuteIncrement(DateTime now, int increment) {
  return DateTime(
    now.year,
    now.month,
    now.day,
    now.hour,
    now.minute + increment,
  );
}

class CenterCircleCanvas extends StatelessWidget {
  final double diameter;
  final Color color;
  final String label;

  const CenterCircleCanvas({
    Key? key,
    this.diameter = 100,
    this.color = const Color(0xFF2196F3),
    required this.label,
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
        Transform.translate(
          offset: Offset(diameter / 2 - 30, 0),
          child: Text(
            label,
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
      ..strokeWidth = 5;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, diameter / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
