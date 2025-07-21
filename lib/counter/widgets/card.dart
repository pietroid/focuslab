import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:focuslab/app/app.dart';

class DefaultCard extends StatelessWidget {
  const DefaultCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(45, 3, 6, 17), // Default card color
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.2),
          //   blurRadius: 1.0,
          //   offset: const Offset(0, 4), // Shadow position
          // ),
        ],
      ),
      child: child,
    );
  }
}
