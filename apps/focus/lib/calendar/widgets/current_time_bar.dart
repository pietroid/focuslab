import 'package:flutter/material.dart';

class CurrentTimeBar extends StatelessWidget {
  const CurrentTimeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 172, 255, 201),
        borderRadius: BorderRadius.circular(3),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(168, 0, 87, 90),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}
