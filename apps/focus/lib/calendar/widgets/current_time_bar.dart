import 'package:flutter/material.dart';

class CurrentTimeBar extends StatelessWidget {
  const CurrentTimeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 80, 232, 255),
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(168, 0, 42, 90),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }
}
