import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.label, this.destructive = false});

  final String label;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.small, horizontal: AppSpacing.medium),
      decoration: BoxDecoration(
        color: AppColors.defaultButtonColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: destructive
              ? const Color.fromARGB(255, 255, 168, 161)
              : Colors.white,
        ),
      ),
    );
  }
}
