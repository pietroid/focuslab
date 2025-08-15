import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddButton extends StatelessWidget {
  AddButton({
    super.key,
    this.onPressed,
  });

  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.extraSmall),
        decoration: BoxDecoration(
          color: AppColors.defaultCardColor,
          borderRadius: BorderRadius.circular(AppSpacing.medium),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
