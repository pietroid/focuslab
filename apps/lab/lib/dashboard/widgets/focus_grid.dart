import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/dashboard/bloc/time_bloc.dart';

class FocusGrid extends StatelessWidget {
  const FocusGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeBloc, TimeState>(builder: (
      context,
      state,
    ) {
      final coreRadius = state.grid.configuration.coreRadius;
      final maxRadius = state.grid.configuration.maxRadius;

      final waves = <CenterCircleCanvas>[];

      for (final timeWidth in state.grid.gridRadiusesPerTimeLength.entries) {
        waves.add(
          generateGrid(
            state.grid.gridRadiusesPerTimeLength[timeWidth.key]!,
            maxRadius,
            coreRadius,
            state.grid.configuration.lineColorForTimeLength[timeWidth.key]!,
            state.grid.configuration.lineWidthForTimeLength[timeWidth.key]!,
          ),
        );
      }

      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: waves.reversed.toList(),
        ),
      );
    });
  }
}

CenterCircleCanvas generateGrid(
  List<double> points,
  double maxRadius,
  double coreRadius,
  Color color,
  double lineWidth,
) {
  return CenterCircleCanvas(
    label: null,
    // ? '${timePoints[i].hour.toString().padLeft(2, '0')}:${timePoints[i].minute.toString().padLeft(2, '0')}'
    // : null,
    diameter: maxRadius * 2 + coreRadius * 2,
    color: color,
    timePoints: points,
    coreRadius: coreRadius,
  );
}

class CenterCircleCanvas extends StatelessWidget {
  final double diameter;
  final List<double> timePoints;
  final double coreRadius;
  final Color color;
  final String? label;

  const CenterCircleCanvas({
    Key? key,
    required this.diameter,
    required this.color,
    this.label,
    required this.timePoints,
    required this.coreRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(diameter, diameter),
          painter: _CenterCirclePainter(
            diameter: diameter,
            color: color,
            timePointsFromCenter:
                timePoints.map((point) => point + coreRadius).toList(),
          ),
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

double proportionalRadius(double radius, double maxRadius) {
  return radius / maxRadius;
}

class _CenterCirclePainter extends CustomPainter {
  final double diameter;
  final Color color;
  final List<double> timePointsFromCenter;

  _CenterCirclePainter({
    required this.diameter,
    required this.color,
    required this.timePointsFromCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final doubleListLength = timePointsFromCenter.length * 2;

    /// List of colors.
    ///
    /// Alternated between full opacity and transparenty
    /// to create a dashed effect.
    final colors = List<Color>.empty(growable: true);

    for (var i = 0; i < doubleListLength - 1; i++) {
      if (i.isEven) {
        final intensity = pow(1 - (i / doubleListLength), 2);
        colors.add((color.withOpacity(color.opacity * intensity.clamp(0, 1))));
      } else {
        colors.add(color.withOpacity(0.0));
      }
    }

    /// List of stops for the gradient,
    /// calculated based on the time points and line width.
    final stops = List<double>.generate(doubleListLength - 1, (i) {
      final currentRadiusIndex = timePointsFromCenter[i ~/ 2];
      if (i == doubleListLength - 2) {
        return 1.0;
      }
      if (i.isEven) {
        /// Return the stop of the full color
        return currentRadiusIndex / diameter;
      } else {
        final pastRadiusIndex = timePointsFromCenter[(i - 1) ~/ 2];
        final nextRadiusIndex = timePointsFromCenter[(i + 1) ~/ 2];

        /// Return the stop of the transparent color, as interpolated between
        /// the current and next radius index.
        return ((pastRadiusIndex + nextRadiusIndex) / 2) / diameter;
      }
    });

    final gradientPaint = Paint()
      ..shader = RadialGradient(
        colors: colors,
        stops: stops,
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: diameter / 2,
        ),
      );
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, diameter / 2, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
