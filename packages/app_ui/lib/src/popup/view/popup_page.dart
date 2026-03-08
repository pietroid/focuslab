import 'dart:ui';

import 'package:app_ui/src/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopupPage extends StatelessWidget {
  const PopupPage({
    super.key,
    required this.content,
  });
  final Widget content;

  static void show({required BuildContext context, required Widget content}) {
    showDialog(
      context: context,
      builder: (context) => PopupPage(content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          child: ColoredBox(
            color: const Color.fromARGB(14, 255, 255, 255),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
                tileMode: TileMode.clamp,
              ),
              child: Dialog.fullscreen(
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.large),
                  child: content,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
