import 'package:flutter/material.dart';
import 'package:focuslab/counter/widgets/oscillating_builder.dart';

class LivingBeing extends StatelessWidget {
  final int levelOfLife;
  const LivingBeing({super.key, required this.levelOfLife});

  @override
  Widget build(BuildContext context) {
    /// Alive and well
    // return OscillatingBuilder(
    //     minValue: 10.0,
    //     maxValue: 40.0,
    //     period: 4.0,
    //     phase: 0.0,
    //     builder: (context, signal, staticChild) {
    //       return Container(
    //         width: 100,
    //         height: 100,
    //         decoration: new BoxDecoration(
    //           color: const Color.fromARGB(255, 255, 255, 255),
    //           shape: BoxShape.circle,
    //           boxShadow: [
    //             BoxShadow(
    //               color:
    //                   const Color.fromARGB(255, 255, 184, 3).withOpacity(1.0),
    //               blurRadius: signal,
    //               offset: const Offset(0, 0), // Shadow position
    //             ),
    //           ],
    //         ),
    //       );
    //     });

    /// Sick
    return OscillatingBuilder(
        minValue: 80.0,
        maxValue: 100.0,
        period: 50.0,
        phase: 0.0,
        builder: (context, signal, staticChild) {
          return Container(
            width: 80,
            height: 80,
            decoration: new BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 58, 0, 0).withOpacity(1.0),
                  blurRadius: signal,
                  offset: const Offset(0, 0), // Shadow position
                ),
              ],
            ),
          );
        });
  }
}
