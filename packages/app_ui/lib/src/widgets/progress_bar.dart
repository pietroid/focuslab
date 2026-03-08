import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.progress,
    required this.maxValue,
  });
  final double progress;
  final double maxValue;

  Color barColorByAmountSpent(double percentageSpent) {
    if (percentageSpent < 50) {
      return const Color.fromARGB(255, 81, 195, 81); // Green
    } else if (percentageSpent < 80) {
      return const Color.fromARGB(255, 195, 195, 81); // Yellow
    } else {
      return const Color.fromARGB(255, 195, 81, 81); // Red
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = barColorByAmountSpent(progress / maxValue * 100);
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.defaultCardColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: (progress / maxValue * 100).toInt(),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              ),
            ),
          ),
          Expanded(
            flex: 100 - (progress / maxValue * 100).toInt(),
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
