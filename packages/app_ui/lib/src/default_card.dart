import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  const DefaultCard({
    super.key,
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.small),
          decoration: BoxDecoration(
            color: AppColors.defaultCardColor,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            boxShadow: [
              // BoxShadow(
              //   color: Colors.black.withOpacity(0.2),
              //   blurRadius: 1.0,
              //   offset: const Offset(0, 4), // Shadow position
              // ),
            ],
          ),
          child: child,
        ));
  }
}
