import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  const DefaultCard({
    required this.child,
    super.key,
    this.gradient,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.small),
        //width: double.infinity,
        decoration: gradient != null
            ? BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(30),
              )
            : BoxDecoration(
                color: AppColors.defaultCardColor,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              ),
        child: child,
      ),
    );
  }
}
