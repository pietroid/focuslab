import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAddButton extends StatelessWidget {
  const HomeAddButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.medium),
        decoration: const BoxDecoration(
          color: Color.fromARGB(16, 255, 255, 255),
          shape: BoxShape.circle,
        ),
        child: const Icon(CupertinoIcons.plus, color: Colors.white, size: 18),
      ),
    );
  }
}
