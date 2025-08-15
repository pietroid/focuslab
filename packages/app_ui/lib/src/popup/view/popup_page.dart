import 'package:app_ui/src/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopupPage extends StatelessWidget {
  final Widget content;
  const PopupPage({
    super.key,
    required this.content,
  });

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
        padding: EdgeInsets.all(AppSpacing.large),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          child: Dialog.fullscreen(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.large),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
