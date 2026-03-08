import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focuslab/counter/widgets/living_being.dart';

class MusicExperienceCanvas extends StatelessWidget {
  const MusicExperienceCanvas({
    required this.beat,
    required this.beatProgress,
    super.key,
  });

  final int beat;
  final double beatProgress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: MusicExperiencePainter(
          beat: beat,
          beatProgress: beatProgress,
        ),
        child: Center(
          child: LivingBeing(
            levelOfLife: (beatProgress * 2).clamp(0.0, 1.0),
          ),
        ),
      ),
    );
  }
}

class MusicExperiencePainter extends CustomPainter {
  MusicExperiencePainter({
    required this.beat,
    required this.beatProgress,
  });

  final int beat;
  final double beatProgress;

  @override
  void paint(Canvas canvas, Size size) {
    // draw a pulsating circle for the current beat
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 117, 125)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = sin(beatProgress * pi) * 300 + 10; // Pulsating effect
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
