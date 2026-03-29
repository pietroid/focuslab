import 'package:flutter/material.dart';

/// {@template action_add_circle_button}
/// A circular button shown beside the media player pill when an event is in
/// progress.
///
/// Tapping it signals the parent to reveal the input pill so the user can
/// queue a new task without interrupting the current one.
///
/// The button deliberately matches the visual language of the action pills:
/// same dark background, translucent border, and drop shadow.
/// {@endtemplate}
class ActionAddCircleButton extends StatelessWidget {
  /// {@macro action_add_circle_button}
  const ActionAddCircleButton({required this.onTap, super.key});

  /// Called when the user taps the button.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 0, 29, 52),
          shape: BoxShape.circle,
          border: Border.fromBorderSide(
            BorderSide(
              color: Color.fromARGB(71, 255, 255, 255),
              width: 0.5,
            ),
          ),
          boxShadow: [BoxShadow(blurRadius: 20, spreadRadius: 5)],
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
