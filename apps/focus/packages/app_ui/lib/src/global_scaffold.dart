import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template global_scaffold}
/// The gradient scaffold to be used across the app.
/// {@endtemplate}
class GlobalScaffold extends StatelessWidget {
  /// {@macro global_scaffold}
  const GlobalScaffold({required this.body, super.key});

  /// The child widget to be displayed inside the scaffold.
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundGradientLightColor,
              AppColors.backgroundGradientDarkColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(child: body),
      ),
    );
  }
}
