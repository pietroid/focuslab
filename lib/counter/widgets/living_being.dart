import 'package:flutter/material.dart';
import 'package:focuslab/counter/widgets/oscillating_builder.dart';

class LivingBeing extends StatelessWidget {
  /// when levelOfLife is 0, the being is sick
  /// when levelOfLife is 1, the being is in the best condition
  final double levelOfLife;
  const LivingBeing({super.key, required this.levelOfLife});

  @override
  Widget build(BuildContext context) {
    final width = 80 + levelOfLife * 20.0;

    final color = Color.lerp(
      const Color.fromARGB(255, 0, 0, 0),
      const Color.fromARGB(255, 255, 255, 255),
      levelOfLife - 0.2,
    )!;

    final glowColor = Color.lerp(
      const Color.fromARGB(255, 76, 0, 0),
      const Color.fromARGB(255, 0, 255, 38),
      levelOfLife,
    )!;

    final oscilationAmplitude = levelOfLife;

    /// Alive and well
    return OscillatingBuilder(
        minValue: 1.1 - oscilationAmplitude * 0.1,
        maxValue: 1.1 + oscilationAmplitude * 0.1,
        period: 6.0,
        phase: 0.1,
        builder: (context, widthSignal, staticChild) {
          return OscillatingBuilder(
              minValue: 20.0 - oscilationAmplitude * 10.0,
              maxValue: 20.0 + oscilationAmplitude * 10.0,
              period: 6.0,
              phase: 0.0,
              builder: (context, blurSignal, staticChild) {
                return Container(
                  width: width * widthSignal,
                  height: width * widthSignal,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor,
                        blurRadius: blurSignal,
                        offset: const Offset(0, 0), // Shadow position
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
