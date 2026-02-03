import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
        color: const Color.fromARGB(255, 255, 255, 255),
        fontWeight: FontWeight.w200);
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.backgroundGradientLightColor,
                  AppColors.backgroundGradientLightColor.withValues(alpha: 0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            '31/Janeiro',
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Text(
            'Hanniquinha',
            style: textStyle?.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: Text(
            'Pico',
            style: textStyle?.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
