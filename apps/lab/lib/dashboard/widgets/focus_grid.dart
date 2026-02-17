import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/dashboard/bloc/time_bloc.dart';
import 'package:focuslab/dashboard/utils/time_grid_builder.dart';

class FocusGrid extends StatelessWidget {
  const FocusGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeBloc, TimeState>(builder: (
      context,
      state,
    ) {
      final coreRadius = state.grid.configuration.coreRadius;

      final waves = <CenterCircleCanvas>[];

      for (final timeWidth in state.grid.gridRadiusesPerTimeLength.entries) {
        waves.addAll(
          generateGrid(
            state.grid.gridRadiusesPerTimeLength[timeWidth.key]!,
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
          children: waves,
        ),
      );
    });
  }
}

List<CenterCircleCanvas> generateGrid(
  List<double> points,
  double coreRadius,
  Color color,
  double lineWidth,
) {
  final waves = <CenterCircleCanvas>[];
  for (int i = 0; i < points.length; i++) {
    final radius = points[i] + coreRadius;

    final maxRadius = points[points.length - 1];
    final alpha = pow((maxRadius - (radius - coreRadius)) / maxRadius, 2);

    /// Create a new wave with the calculated radius and label
    final circle = CenterCircleCanvas(
      label: null,
      // ? '${timePoints[i].hour.toString().padLeft(2, '0')}:${timePoints[i].minute.toString().padLeft(2, '0')}'
      // : null,
      diameter: radius * 2,
      color: color.withOpacity(alpha.toDouble()),
      lineWidth: lineWidth,
    );

    waves.add(circle);
  }

  return waves;
}

class CenterCircleCanvas extends StatelessWidget {
  final double diameter;
  final Color color;
  final String? label;
  final double lineWidth;

  const CenterCircleCanvas({
    Key? key,
    this.diameter = 100,
    required this.color,
    required this.lineWidth,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(diameter, diameter),
          painter: _CenterCirclePainter(
              diameter: diameter, color: color, lineWidth: lineWidth),
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
  final double lineWidth;

  _CenterCirclePainter(
      {required this.diameter, required this.color, required this.lineWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, diameter / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
