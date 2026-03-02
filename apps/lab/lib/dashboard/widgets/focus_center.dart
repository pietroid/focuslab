import 'package:flutter/widgets.dart';
import 'package:focuslab/dashboard/widgets/clock.dart';
import 'package:focuslab/dashboard/widgets/focus_grid.dart';

class FocusCenter extends StatelessWidget {
  const FocusCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: const Stack(
        fit: StackFit.expand,
        children: [
          FocusGrid(),
          CenterCircleCanvas(
            diameter: 200,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          Center(child: Clock()),
        ],
      ),
    );
  }
}

class CenterCircleCanvas extends StatelessWidget {
  final double diameter;
  final Color color;

  const CenterCircleCanvas({
    Key? key,
    this.diameter = 100,
    this.color = const Color(0xFF2196F3),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(diameter, diameter),
      painter: _CenterCirclePainter(diameter: diameter, color: color),
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
      ..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, diameter / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
